defmodule ApaNumber do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Parser to handle number string inputs
  convert any number string to a tuple of 2 integers:
  {integer_value, exp}

  Maybe better to make parse private and force to use from_string/1 - because of possible inifinite loop
  """
  defp parse("-" <> binary) do
    "-" <> parse_unsigned(binary)
  end

  defp parse("+" <> binary), do: parse_unsigned(binary)

  defp parse(binary), do: parse_unsigned(binary)

  defp parse_unsigned(<<digit, rest::binary>>) when digit in ?0..?9 do
    parse_unsigned(rest, false, false, <<digit>>)
  end

  defp parse_unsigned(binary) when is_binary(binary), do: :error

  defp parse_unsigned(<<digit, rest::binary>>, dot?, e?, acc) when digit in ?0..?9 do
    parse_unsigned(rest, dot?, e?, <<acc::binary, digit>>)
  end

  defp parse_unsigned(<<?., rest::binary>>, false, false, acc) do
    parse_unsigned(rest, true, false, <<acc::binary, ?.>>)
  end

  defp parse_unsigned(<<exp_marker, sign, rest::binary>>, dot?, false, acc)
       when exp_marker in 'eE' and sign in '-+' do
    expo = parse_expo(<<rest::binary>>)
    expo = String.to_integer(<<sign, expo::binary>>)
    {int_value, exp} = from_parsed_string(acc)
    new_acc = ApaNumber.to_string({int_value, exp + expo})

    parse_unsigned("", dot?, true, <<new_acc::binary>>)
  end

  defp parse_unsigned(<<exp_marker, rest::binary>>, dot?, false, acc)
       when exp_marker in 'eE' do
    expo = String.to_integer(parse_expo(<<rest::binary>>))
    {int_value, exp} = from_parsed_string(acc)
    new_acc = ApaNumber.to_string({int_value, exp + expo})

    parse_unsigned("", dot?, true, <<new_acc::binary>>)
  end

  defp parse_unsigned(_rest, _dot?, _e?, acc) do
    acc
  end

  defp parse_expo(<<digit, rest::binary>>) when digit in ?0..?9 do
    parse_expo(rest, false, <<digit>>)
  end

  defp parse_expo(binary) when is_binary(binary) do
    "0"
  end

  defp parse_expo(<<digit, rest::binary>>, e?, acc) when digit in ?0..?9 do
    parse_expo(rest, e?, <<acc::binary, digit>>)
  end

  defp parse_expo(_rest, _e?, acc) do
    acc
  end

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
    {3000000000000, 0}

    iex> ApaNumber.from_string("+0003e+00000")
    {3, 0}

    iex> ApaNumber.from_string("+0003.00e+00000 Dollar")
    {3, 0}
  """
  @spec from_string(binary) :: {integer, integer} | :error
  def from_string(binary) do
    case parse(binary) do
      :error ->
        :error

      number_string ->
        from_parsed_string(number_string)
    end
  end

  defp from_parsed_string(number_string) do
    if String.contains?(number_string, ".") do
      [d1, d2] =
        number_string
        |> String.trim_trailing("0")
        |> String.split(".")

      exp = String.length(d2) * -1

      int_value =
        [d1, d2]
        |> Enum.join()
        |> String.to_integer()

      {int_value, exp}
    else
      int_value = String.to_integer(number_string)
      exp = 0
      {int_value, exp}
    end
  end

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
  def to_string(number_tuple, precision \\ 30, scale \\ 30)

  def to_string({int_value, exp}, precision, _scale) when exp == 0 and precision >= 0 do
    to_string_integer(int_value, String.length(Kernel.to_string(abs(int_value))), precision)
  end

  def to_string({int_value, exp}, _precision, _scale) when exp < 0 do
    {d1, d2} =
      Kernel.to_string(int_value)
      |> String.trim_leading("+")
      |> String.trim_leading("-")
      |> String.trim_leading("0")
      |> String.split_at(exp)

    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)
    d2_filled = fill_if_needed(d2, abs(exp))

    "#{sign}#{d1_filled}.#{d2_filled}"
  end

  def to_string({int_value, exp}, precision, _scale) when exp > 0 and precision == 0 do
    d1_filled =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(exp)

    "#{d1_filled}"
  end

  def to_string({int_value, exp}, precision, _scale) when exp > 0 and precision > 0 do
    abs_int_string = Kernel.to_string(abs(int_value))
    abs_int_string_length = String.length(abs_int_string)

    if precision <= abs_int_string_length do
      d1_precision =
        abs_int_string
        |> reduce_to_precision(precision)
        |> fill_up_string_trailing_zeros(abs_int_string_length - precision + exp)

      sign = sign_of(int_value)

      "#{sign}#{d1_precision}"
    else
      to_string({int_value, exp}, 0, 0)
    end
  end

  ########## to_string_integer

  defp to_string_integer(int_value, length, precision)
       when length > precision and precision > 0 do
    {d1, _d2} =
      Kernel.to_string(int_value)
      |> String.trim_leading("-")
      |> String.split_at(precision)

    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)
    d2_filled = fill_up_string_trailing_zeros("", length - precision)

    "#{sign}#{d1_filled}#{d2_filled}"
  end

  defp to_string_integer(int_value, _length, _precision) do
    Kernel.to_string(int_value)
  end

  defp reduce_to_precision(int_string, precision) do
    {shrinked, _rest} = String.split_at(int_string, precision)
    shrinked
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
    new_value =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(abs(shift_decimal_point) - abs(exp))
      |> String.to_integer()

    {new_value, shift_decimal_point}
  end

  def shift_to({int_value, exp}, shift_decimal_point) do
    counted_zeros = count_trailing_zeros(int_value)
    diff = shift_decimal_point - exp

    if counted_zeros >= diff do
      new_int = remove_number_of_zeros(int_value, diff)
      {new_int, shift_decimal_point}
    else
      # Impossible operation - return the orig input - see doc
      {int_value, exp}
    end
  end

  @doc """
  Adds a minus sign to a number string if necessary.
  Could be done by converting to integer and multiply with -1 and reconvert to string.
  But this works nice and elegant with strings and pattern matching too.

  ## Examples

    iex> ApaNumber.add_minus_sign("3")
    "-3"

    iex> ApaNumber.add_minus_sign("+3")
    "-3"

    iex> ApaNumber.add_minus_sign("-3")
    "3"

    iex> ApaNumber.add_minus_sign("-0003.0003e-002")
    "0003.0003e-002"
  """
  @spec add_minus_sign(binary()) :: binary()
  def add_minus_sign(<<sign, number_string::binary>>) when sign in '+' do
    "-" <> number_string
  end

  def add_minus_sign(<<sign, number_string::binary>>) when sign in '-' do
    number_string
  end

  def add_minus_sign(number_string) do
    "-" <> number_string
  end

  defp remove_number_of_zeros(int_value, 0), do: int_value

  defp remove_number_of_zeros(rest_int, acc) do
    if rem(rest_int, 10) == 0 do
      remove_number_of_zeros(div(rest_int, 10), acc - 1)
    end
  end

  defp count_trailing_zeros(int_value, acc \\ 0)

  defp count_trailing_zeros(0, acc), do: acc

  defp count_trailing_zeros(rest, acc) do
    if rem(rest, 10) == 0 do
      count_trailing_zeros(div(rest, 10), acc + 1)
    else
      count_trailing_zeros(0, acc)
    end
  end

  defp sign_of(int_value) when int_value < 0 do
    "-"
  end

  defp sign_of(_int_value) do
    ""
  end

  defp fill_if_empty(int_string) when int_string == <<>> do
    fill_up_string_leading_zeros(int_string, 1)
  end

  defp fill_if_empty(int_string) do
    int_string
  end

  defp fill_if_needed(int_string, abs_decimal_point) when abs_decimal_point >= 0 do
    if String.length(int_string) < abs_decimal_point do
      fill_up_string_leading_zeros(
        int_string,
        abs_decimal_point - String.length(int_string)
      )
    else
      int_string
    end
  end

  defp fill_up_string_leading_zeros(fill_up_string, zeros_count) do
    "#{String.duplicate("0", zeros_count)}#{fill_up_string}"
  end

  defp fill_up_string_trailing_zeros(fill_up_string, zeros_count) do
    "#{fill_up_string}#{String.duplicate("0", zeros_count)}"
  end
end
