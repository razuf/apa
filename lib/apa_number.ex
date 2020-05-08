defmodule ApaNumber do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Parser to handle number string inputs
  convert any number string to a tuple of 2 integers:
  {integer_value, exp}
  """
  @precision_default Application.get_env(:apa, :precision_default, -1)
  @scale_default Application.get_env(:apa, :scale_default, -1)
  @parse_digit_memory_speed_border Application.get_env(:apa, :parse_digit_memory_speed_border, 22)

  @doc """
  Parses a binary (number string) into an ApaNumber tuple.

  It works with signs, leading and trailing zeros and additional chars will be ignored.
  If successful, returns a tuple in the form of `{integer_value, exponent}`:

  ApaNumber.from_string("+0003.00e+00000 Dollar")
  {3, 0}

  When the binary cannot be parsed, the atom `:error` will be returned.

  The limit only depends on the internal integers - because of Elixir "unlimited" integers  I would say "arbitrary".

  Used elixir source from Float module for parsing - nice source of inspiration! Thank you José!

  ## Examples

    iex> ApaNumber.from_string("0003")
    {3, 0}

    iex> ApaNumber.from_string("+0003")
    {3, 0}

    iex> ApaNumber.from_string("-0003")
    {-3, 0}

    iex> ApaNumber.from_string("-0000120.1200")
    {-12012, -2}

    iex> ApaNumber.from_string("-0000120.1200")
    {-12012, -2}

    iex> ApaNumber.from_string("-03 Euro")
    {-3, 0}

    iex> ApaNumber.from_string("-0003e-2")
    {-3, -2}

    iex> ApaNumber.from_string("-3e-0002")
    {-3, -2}

    iex> ApaNumber.from_string("3e-12")
    {3, -12}

    iex> ApaNumber.from_string("+0003e+12")
    {3, 12}

    iex> ApaNumber.from_string("+0003e+00000")
    {3, 0}

    iex> ApaNumber.from_string("+0003.00e+00000 Dollar")
    {3, 0}
  """
  @spec from_string(binary) :: {integer, integer} | :error
  def from_string(binary) do
    parse(binary)
  end

  ###################################################################################################
  # Parsing
  ###################################################################################################
  @spec parse(binary) :: {integer, integer} | :error
  def parse("+" <> rest) when byte_size(rest) + 1 > @parse_digit_memory_speed_border do
    parse_unsigned_decimal(rest)
  end

  def parse("-" <> rest) when byte_size(rest) + 1 > @parse_digit_memory_speed_border do
    case parse_unsigned_decimal(rest) do
      {int_value, exp} -> {int_value * -1, exp}
      :error -> :error
    end
  end

  def parse(binary)
      when byte_size(binary) > @parse_digit_memory_speed_border and is_binary(binary) do
    parse_unsigned_decimal(binary)
  end

  def parse("+" <> rest) do
    parse_unsigned(rest)
  end

  def parse("-" <> rest) do
    case parse_unsigned(rest) do
      {int_value, exp} -> {int_value * -1, exp}
      :error -> :error
    end
  end

  def parse(binary) when is_binary(binary) do
    parse_unsigned(binary)
  end

  ###################################################################################################
  # Decimal like version for improve speed in case of bigger strings
  # at the cost of more memory consumption - see @parse_digit_memory_speed_border in docs
  ###################################################################################################
  defp parse_unsigned_decimal(bin) do
    {int, rest} = parse_digits_decimal(bin)
    {float, rest} = parse_float_decimal(rest)
    {exp, _rest} = parse_exp_decimal(rest)

    if int == [] and float == [] do
      :error
    else
      int = if int == [], do: '0', else: int
      exp = if exp == [], do: '0', else: exp

      {List.to_integer(int ++ float), List.to_integer(exp) - length(float)}
    end
  end

  defp parse_float_decimal("." <> rest), do: parse_digits_decimal(rest)
  defp parse_float_decimal(bin), do: {[], bin}

  defp parse_exp_decimal(<<e, rest::binary>>) when e in [?e, ?E] do
    case rest do
      <<sign, rest::binary>> when sign in [?+, ?-] ->
        {digits, rest} = parse_digits_decimal(rest)
        {[sign | digits], rest}

      _ ->
        parse_digits_decimal(rest)
    end
  end

  defp parse_exp_decimal(bin), do: {[], bin}

  defp parse_digits_decimal(bin), do: parse_digits_decimal(bin, [])

  defp parse_digits_decimal(<<digit, rest::binary>>, acc) when digit in ?0..?9 do
    parse_digits_decimal(rest, [digit | acc])
  end

  defp parse_digits_decimal(rest, acc) do
    {:lists.reverse(acc), rest}
  end

  ###################################################################################################
  # Apa version - with more speed for less then 22 digits an much less memory consumption
  ###################################################################################################
  defp parse_unsigned(bin) do
    {int, _int_len, int_trailing_zeros, int_rest} = parse_digits(bin)

    if int == :error do
      :error
    else
      if int_rest == "" do
        parse_unsigned_integer(int, int_trailing_zeros)
      else
        {float, float_len, float_trailing_zeros, float_rest} = parse_float(int_rest)

        if float_rest == "" do
          if float == :error do
            parse_unsigned_integer(int, int_trailing_zeros)
          else
            float = div(float, ApaNumber.pow10(float_trailing_zeros))

            if float == 0 do
              parse_unsigned_integer(int, int_trailing_zeros)
            else
              parse_unsigned_float(int, float, float_len, float_trailing_zeros)
            end
          end
        else
          {exp, _exp_rest} = parse_exp(float_rest)

          if exp == :error do
            if float == :error do
              parse_unsigned_integer(int, int_trailing_zeros)
            else
              if float == 0 do
                {int, int_trailing_zeros}
              else
                parse_unsigned_float(int, float, float_len, float_trailing_zeros)
              end
            end
          else
            if float == :error do
              parse_unsigned_integer(int, int_trailing_zeros, exp)
            else
              if float == 0 do
                parse_unsigned_integer(int, int_trailing_zeros, exp)
              else
                parse_unsigned_float(int, float, float_len, float_trailing_zeros, exp)
              end
            end
          end
        end
      end
    end
  end

  defp parse_unsigned_integer(int, int_trailing_zeros) do
    int = div(int, ApaNumber.pow10(int_trailing_zeros))
    {int, int_trailing_zeros}
  end

  defp parse_unsigned_integer(int, int_trailing_zeros, exp) do
    int = div(int, ApaNumber.pow10(int_trailing_zeros))
    {int, int_trailing_zeros + exp}
  end

  defp parse_unsigned_float(int, float, float_len, float_trailing_zeros) do
    int_value = int * ApaNumber.pow10(float_len - float_trailing_zeros) + float
    float_exp = float_trailing_zeros - float_len
    {int_value, float_exp}
  end

  defp parse_unsigned_float(int, float, float_len, float_trailing_zeros, exp) do
    float = div(float, ApaNumber.pow10(float_trailing_zeros))
    int_value = int * ApaNumber.pow10(float_len - float_trailing_zeros) + float
    float_exp = float_trailing_zeros - float_len
    {int_value, float_exp + exp}
  end

  defp parse_float("." <> rest), do: parse_digits(rest)
  defp parse_float(bin), do: {:error, 0, 0, bin}

  defp parse_exp(<<e, rest::binary>>) when e in [?e, ?E] do
    case rest do
      <<sign, rest::binary>> when sign in [?-] ->
        {exp, _exp_len, _exp_trailing_zeros, exp_rest} = parse_digits(rest)
        {-1 * exp, exp_rest}

      <<sign, rest::binary>> when sign in [?+] ->
        {exp, _exp_len, _exp_trailing_zeros, exp_rest} = parse_digits(rest)
        {exp, exp_rest}

      _ ->
        {exp, _exp_len, _exp_trailing_zeros, exp_rest} = parse_digits(rest)
        {exp, exp_rest}
    end
  end

  defp parse_exp(bin) do
    {0, bin}
  end

  defp parse_digits(<<digit, rest::binary>>) when digit in ?0..?9 do
    parse_digits(rest, digit - 48, 0, 1)
  end

  defp parse_digits(rest), do: {:error, 0, 0, rest}

  defp parse_digits(<<digit, rest::binary>>, acc, trailing_zeros, len)
       when digit in ?0..?9 do
    trailing_zeros = if digit == 48 and acc > 0, do: trailing_zeros + 1, else: 0

    # unbelievable but mult by 10 is so time expensive here !!! there is a difference of 280 K in 5 sec
    # maybe because of recursion
    # 404.86 K in 5 sec (benchee)
    # parse_digits(rest, acc + 10 + (digit - 48), trailing_zeros, len + 1)

    # 123.90 K in 5 sec (benchee)
    parse_digits(rest, acc * 10 + (digit - 48), trailing_zeros, len + 1)
  end

  defp parse_digits(rest, acc, trailing_zeros, len),
    do: {acc, len, trailing_zeros, rest}

  ###################################################################################################

  @doc """
  Creates a string from an ApaNumber tuple.

  ## Examples

    iex> ApaNumber.to_string({3, 0})
    "3"

    iex> ApaNumber.to_string({-3, 0})
    "-3"

    iex> ApaNumber.to_string({3, 3})
    "3000"

    iex> ApaNumber.to_string({-12012, -2})
    "-120.12"

    iex> ApaNumber.to_string({-3997, -6})
    "-0.003997"
  """
  @spec to_string({integer(), integer()}, integer(), integer()) :: binary | :error
  def to_string(number_tuple, precision \\ @precision_default, scale \\ @scale_default)

  def to_string({int_value, _exp}, precision, scale) when int_value == 0 do
    to_string_integer({0, 0}, precision, scale)
  end

  def to_string({int_value, exp}, precision, scale) when exp >= 0 do
    to_string_integer({int_value, exp}, precision, scale)
  end

  def to_string({int_value, exp}, precision, scale) when exp < 0 and int_value < 0 do
    "-" <> to_string_decimals({int_value * -1, exp}, precision, scale)
  end

  def to_string({int_value, exp}, precision, scale) when exp < 0 do
    to_string_decimals({int_value, exp}, precision, scale)
  end

  ########## to_string_integer  exp >= 0
  defp to_string_integer({int_value, exp}, precision, scale) do
    {shifted_int, 0} = shift_to({int_value, exp}, 0)

    Integer.to_string(shifted_int)
    |> scale_up_integer(scale, exp)
  end

  defp scale_up_integer(int_string, scale, exp) when scale <= 0 do
    int_string
  end

  defp scale_up_integer(int_string, scale, exp) when scale > 0 do
    # Todo: check speed with benchee String.duplicate/2
    # maybe better :lists.duplicate(scale, ?0)
    scale_zeros = String.duplicate("0", scale)
    "#{int_string}.#{scale_zeros}"
  end

  ########## to_string_decimals  exp < 0
  defp to_string_decimals({int_value, exp}, precision, scale) when scale == 0 do
    int_value
    |> div(ApaNumber.pow10(abs(scale + exp)))
    |> Integer.to_charlist()
    |> IO.iodata_to_binary()
  end

  defp to_string_decimals({int_value, exp}, precision, scale) when scale < 0 do
    int_value
    |> Integer.to_charlist()
    |> list_and_length()
    |> to_string_decimals_list(exp)
    |> IO.iodata_to_binary()
  end

  defp to_string_decimals({int_value, exp}, precision, scale) when scale + exp >= 0 do
    zeros = scale + exp

    (int_value * ApaNumber.pow10(zeros))
    |> Integer.to_charlist()
    |> list_and_length()
    |> to_string_decimals_list(-scale)
    |> IO.iodata_to_binary()
  end

  defp to_string_decimals({int_value, exp}, precision, scale) when scale + exp < 0 do
    shrink = abs(scale + exp)

    div(int_value, ApaNumber.pow10(shrink))
    |> Integer.to_charlist()
    |> list_and_length()
    |> to_string_decimals_list(-scale)
    |> IO.iodata_to_binary()
  end

  ###
  defp to_string_decimals_list({list, list_len}, exp) when list_len + exp > 0 do
    List.insert_at(list, list_len + exp, ?.)
  end

  defp to_string_decimals_list({list, list_len}, exp) do
    '0.' ++ :lists.duplicate(-(list_len + exp), ?0) ++ list
  end

  defp list_and_length(list) do
    {list, length(list)}
  end

  @doc """
  Shifts an ApaNumber to another decimal point
  to work with the intended integer calculation of two numbers with the same decimal point
  this operation do not change the mathematical value:
  ApaNumber.to_string({2, -1}) == "0.2" ~math-equal~ ApaNumber.to_string({20, -2}) == "0.20"
  and always shift_decimal_point > exp because fillup with zeros
  reduce non existing zeros is not possible and not necessary to implement
  returns the shifted ApaNumber tupel or if not possible to shift the input tupel
  ## Examples

    iex> ApaNumber.shift_to({2, -1}, -2)
    {20, -2}

    iex> ApaNumber.shift_to({2, -1}, -4)
    {2000, -4}

    iex> ApaNumber.shift_to({2000, -1}, 0)
    {200, 0}

    iex> ApaNumber.shift_to({2000, -4}, -1)
    {2, -1}

    iex> ApaNumber.shift_to({20, -1}, 0)
    {2, 0}
  """
  @spec shift_to({integer(), integer()}, integer()) :: {integer(), integer()}
  def shift_to({int_value, exp}, shift_decimal_point)
      when exp == shift_decimal_point do
    {int_value, exp}
  end

  def shift_to({int_value, exp}, shift_decimal_point)
      when abs(exp) < abs(shift_decimal_point) do
    diff = shift_decimal_point - exp
    int_value = int_value * pow10(abs(diff))
    {int_value, shift_decimal_point}
  end

  def shift_to({int_value, exp}, shift_decimal_point) do
    counted_zeros = count_trailing_zeros(int_value)
    diff = shift_decimal_point - exp

    if counted_zeros > 0 and counted_zeros >= diff do
      new_int = remove_number_of_zeros(int_value, diff)
      {new_int, shift_decimal_point}
    else
      int_value = int_value * pow10(abs(diff))
      {int_value, shift_decimal_point}
    end
  end

  ### helper

  defp count_trailing_zeros(int_value, acc \\ 0)

  defp count_trailing_zeros(0, acc), do: acc

  defp count_trailing_zeros(rest, acc) do
    if rem(rest, 10) == 0 do
      count_trailing_zeros(div(rest, 10), acc + 1)
    else
      count_trailing_zeros(0, acc)
    end
  end

  defp remove_number_of_zeros(int_value, 0), do: int_value

  defp remove_number_of_zeros(rest_int, acc) do
    if rem(rest_int, 10) == 0 do
      remove_number_of_zeros(div(rest_int, 10), acc - 1)
    end
  end

  @doc """
  This is based on Decimal version of pow10 (cool!!! - is much faster then my version).
  Extended with :error guard for < 0 - in case that ever happen.

  ## Examples

    iex> ApaNumber.pow10(3)
    1000

    iex> ApaNumber.pow10(0)
    1
  """
  @spec pow10(non_neg_integer()) :: non_neg_integer()

  Enum.reduce(0..104, 1, fn int, acc ->
    def pow10(unquote(int)), do: unquote(acc)
    defp base10?(unquote(acc)), do: true
    acc * 10
  end)

  def pow10(num) when num > 104, do: pow10(104) * pow10(num - 104)
  def pow10(num) when num < 0, do: :error
end
