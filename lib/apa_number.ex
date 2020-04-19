defmodule ApaNumber do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Helper to handle number string inputs
  convert any number string to a tuple of 2 integers:
  {integer_value, exp}
  """

  # Maybe better to make parse private and force to use from_string/1 - because of possible inifinite loop

  @spec parse(binary) :: binary | :error
  defp parse("-" <> binary) do
    "-" <> parse_unsigned(binary)
  end

  defp parse("+" <> binary) do
    parse_unsigned(binary)
  end

  defp parse(binary) do
    parse_unsigned(binary)
  end

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
        |> clean_float_string()
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
  Create a string from an ApaNumber tuple.

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
  def to_string({int_value, exp}) when exp == 0 do
    Kernel.to_string(int_value)
  end

  def to_string({int_value, exp}) when exp < 0 do
    {d1, d2} =
      Kernel.to_string(int_value)
      |> clean_abs_int_string()
      |> String.split_at(exp)

    sign = sign_of(int_value)
    d1_filled = fill_if_empty(d1)
    d2_filled = fill_if_needed(d2, abs(exp))

    "#{sign}#{d1_filled}.#{d2_filled}"
  end

  def to_string({int_value, exp}) when exp > 0 do
    d1_filled =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(exp)

    "#{d1_filled}"
  end

  @doc """
  Shift an ApaNumber to another decimal point
  to work with the intended integer calculation of two numbers with the same decimal point
  this operation do not change the mathematical value:
  ApaNumber.to_string({2, -1}) == "0.2" ~math-equal~ ApaNumber.to_string({20, -2}) == "0.20"
  and always shift_decimal_point > exp because fillup with zeros
  reduce non existing zeros is not possible and not necessary to implement

  ## Examples

      iex> ApaNumber.shift_to({2, -1}, -2)
      {20, -2}

      iex> ApaNumber.shift_to({2, -1}, -4)
      {2000, -4}


  """
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
    count_zeros = count_trailing_zeros(int_value)
    diff = shift_decimal_point - exp

    if count_zeros >= diff do
      new_int = remove_trailing_zeros(int_value, diff)
      {new_int, shift_decimal_point}
    else
      raise(ArgumentError, "Impossible operation - see doc.")
    end
  end

  defp remove_trailing_zeros(int_value, count_zeros) do
    int_value
    |> Kernel.to_string()
    |> String.codepoints()
    |> Enum.reverse()
    |> remove_zeros(count_zeros)
    |> Enum.reverse()
    |> Enum.join()
    |> String.to_integer()
  end

  def fill_up_trailing_zeros(int_value, count_zeros) do
    int_value
    |> Kernel.to_string()
    |> fill_up_string_trailing_zeros(count_zeros)
    |> String.to_integer()
  end

  defp remove_zeros(list, 0), do: list

  defp remove_zeros([head | tail], acc) do
    if head == "0" do
      remove_zeros(tail, acc - 1)
    else
      raise(ArgumentError, "Not implemeted - wrong usage - see doc.")
    end
  end

  defp count_trailing_zeros(int_value) do
    int_value
    |> Kernel.to_string()
    |> String.codepoints()
    |> Enum.reverse()
    |> count_zeros()
  end

  defp count_zeros(list, acc \\ 0)

  defp count_zeros([], acc), do: acc

  defp count_zeros([head | tail], acc) do
    if head == "0" do
      count_zeros(tail, acc + 1)
    else
      count_zeros([], acc)
    end
  end

  def sign_of(int_value) when int_value < 0 do
    "-"
  end

  def sign_of(_int_value) do
    ""
  end

  def fill_if_empty(int_string) when int_string == <<>> do
    fill_up_string_leading_zeros(int_string, 1)
  end

  def fill_if_empty(int_string) do
    int_string
  end

  def fill_if_needed(int_string, abs_decimal_point) when abs_decimal_point >= 0 do
    if String.length(int_string) < abs_decimal_point do
      fill_up_string_leading_zeros(
        int_string,
        abs_decimal_point - String.length(int_string)
      )
    else
      int_string
    end
  end

  def clean_float_string(float_string) do
    float_string
    |> String.trim_trailing("0")
  end

  def add_minus_sign(number_string) do
    first_sign = String.first(number_string)

    case first_sign do
      "+" ->
        new = number_string |> String.trim_leading("+")
        "-" <> new

      "-" ->
        number_string |> String.trim_leading("-")

      _ ->
        "-" <> number_string
    end
  end

  ###### old stuff ####################

  @doc """
  clean number strings - signs, leading and trailing zeros etc.

  ## Examples

      iex> ApaNumber.clean("0003")
      "3"

      iex> ApaNumber.clean("+0003")
      "3"

      iex> ApaNumber.clean("-0003")
      "3"

      iex> ApaNumber.clean("0000120.1200")
      "120.12"

  """
  def clean(number_string) do
    if String.contains?(number_string, ".") do
      clean_abs_float_string(number_string)
    else
      clean_abs_int_string(number_string)
    end
  end

  def clean_abs_int_string(int_string) do
    int_string
    |> String.trim_leading("+")
    |> String.trim_leading("-")
    |> String.trim_leading("0")
  end

  def clean_abs_float_string(float_string) do
    float_string
    |> String.trim_leading("+")
    |> String.trim_leading("-")
    |> String.trim_leading("0")
    |> String.trim_trailing("0")
    |> String.trim_trailing(".")
  end

  def diff_count(calc_string, diff_string) do
    max(0, String.length(diff_string) - String.length(calc_string))
  end

  def digits_list_reverse(digits_string) do
    digits_string
    |> String.codepoints()
    |> Enum.reverse()
  end

  def fill_up_string_leading_zeros(fill_up_string, zeros_count) do
    "#{String.duplicate("0", zeros_count)}#{fill_up_string}"
  end

  def fill_up_string_trailing_zeros(fill_up_string, zeros_count) do
    "#{fill_up_string}#{String.duplicate("0", zeros_count)}"
  end

  def remove_leading_zeros(list) when length(list) > 1 do
    list
    |> Enum.drop_while(fn x -> x == 0 end)
  end

  def remove_leading_zeros(list) do
    list
  end
end
