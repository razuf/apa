defmodule ApaNumber do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Parser to handle number string inputs
  convert any number string to a tuple of 2 integers:
  {integer_value, exp}
  """
  @precision_default Application.get_env(:apa, :precision_default, -1)
  @scale_default Application.get_env(:apa, :scale_default, -1)

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
  def to_string(number_tuple, precision \\ @precision_default, scale \\ @scale_default)

  # ApaNumber for NaN - Not a Number - used for division by zero
  def to_string({0, 1}, _precision, _scale) do
    "NaN"
  end

  def to_string({int_value, exp}, precision, scale) when exp >= 0 do
    to_string_integer({int_value, exp}, abs_int_length(int_value), precision, scale)
  end

  def to_string({int_value, exp}, precision, scale) when exp < 0 do
    to_string_decimals({int_value, exp}, precision, scale)
  end

  ########## to_string_integer  exp >= 0
  defp to_string_integer({int_value, exp}, abs_length, precision, scale) when scale > 0 do
    int_string = to_string_integer({int_value, exp}, abs_length, precision, 0)
    scaling_integer(int_string, scale)
  end

  defp to_string_integer({int_value, exp}, abs_length, precision, _scale)
       when abs_length >= precision and
              precision > 0 do
    {d1, _d2} =
      int_value
      |> abs()
      |> Kernel.to_string()
      |> String.split_at(precision)

    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)
    d2_filled = fill_up_string_trailing_zeros("", abs_length - precision + exp)

    "#{sign}#{d1_filled}#{d2_filled}"
  end

  defp to_string_integer({int_value, exp}, _abs_length, _precision, _scale) do
    d1_filled =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(exp)

    "#{d1_filled}"
  end

  ########## to_string_decimals  exp < 0

  defp to_string_decimals({int_value, exp}, precision, scale) when scale == 0 do
    {d1, _d2} = int_abs_string_split(int_value, exp, precision, scale)
    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)

    "#{sign}#{d1_filled}"
  end

  defp to_string_decimals({int_value, exp}, precision, scale) when scale < 0 do
    {d1, d2} = int_abs_string_split(int_value, exp, precision, scale)
    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)

    abs_int_string_length = String.length(d2)
    d2_filled = fill_leading(d2, abs_int_string_length, abs(exp))

    "#{sign}#{d1_filled}.#{d2_filled}"
  end

  defp to_string_decimals({int_value, exp}, precision, scale) do
    {d1, d2} = int_abs_string_split(int_value, exp, precision, scale)
    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)

    abs_int_string_length = String.length(d2)
    d2_filled = fill_leading(d2, abs_int_string_length, abs(exp))
    # Todo: rounding here
    d2_filled_length = String.length(d2_filled)
    d2_scaled = scaling(d2_filled, d2_filled_length, scale)

    "#{sign}#{d1_filled}.#{d2_scaled}"
  end

  ### helper

  defp scaling_integer(int_string, scale) do
    scale_zeros = String.duplicate("0", scale)

    "#{int_string}.#{scale_zeros}"
  end

  defp int_abs_string_split(int_value, split_point, precision, _scale) do
    to_string_integer({int_value, 0}, abs_int_length(int_value), precision, 0)
    |> String.trim_leading("-")
    |> String.split_at(split_point)
  end

  defp abs_int_length(int_value) do
    int_value
    |> abs()
    |> Kernel.to_string()
    |> String.length()
  end

  defp sign_of(int_value) when int_value < 0 do
    "-"
  end

  defp sign_of(_int_value) do
    ""
  end

  defp fill_if_empty(int_string) when int_string == <<>> do
    fill_up_string_leading_zeros("", 1)
  end

  defp fill_if_empty(int_string) do
    int_string
  end

  # abs_decimal_point > 0

  defp fill_leading(abs_int_string, abs_int_string_length, abs_decimal_point)
       when abs_int_string_length < abs_decimal_point do
    fill_up_string_leading_zeros(
      abs_int_string,
      abs_decimal_point - abs_int_string_length
    )
  end

  defp fill_leading(
         abs_int_string,
         _abs_int_string_length,
         _abs_decimal_point
       ) do
    abs_int_string
  end

  defp scaling(int_string, int_string_length, scale)
       when int_string_length < scale do
    fill_up_string_trailing_zeros(int_string, scale - int_string_length)
  end

  defp scaling(int_string, int_string_length, scale)
       when int_string_length > scale do
    int_string
    |> String.slice(0, scale)
  end

  defp scaling(int_string, int_string_length, scale)
       when int_string_length == scale do
    int_string
  end

  defp fill_up_string_leading_zeros(fill_up_string, zeros_count) do
    "#{String.duplicate("0", zeros_count)}#{fill_up_string}"
  end

  defp fill_up_string_trailing_zeros(fill_up_string, zeros_count) do
    "#{fill_up_string}#{String.duplicate("0", zeros_count)}"
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
end
