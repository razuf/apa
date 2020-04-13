defmodule ApaNumber do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Helper to handle number string inputs
  convert any number string to a tuple of 2 integers:
  {integer_value, decimal_point}

  """

  @doc """
  Parses a binary (number string) into an ApaNumber tuple - it takes care about signs, leading and trailing zeros etc.

  If successful, returns a tuple in the form of `{integer_value, decimal_point}`.
  When the binary cannot be parsed, the atom `:error` will be returned.
  The limit of the maximum size needs to checked - I cannot imagine any limit at the moment because of the "unlimited" integer
  representation.
  Used elixir source from Float module - nice source of inspiration! Thank you José!

  ## Examples

      iex> ApaNumber.parse("03")
      "03"

      iex> ApaNumber.parse("+03")
      "03"

      iex> ApaNumber.parse("-0003 Euro")
      "-0003"

      # iex> ApaNumber.parse("-0003e-2")
      "-0.03"

  """

  @spec parse(binary) :: binary | :error
  def parse("-" <> binary) do
    case parse_unsigned(binary) do
      :error -> :error
      number -> "-" <> number
    end
  end

  def parse("+" <> binary) do
    parse_unsigned(binary)
  end

  def parse(binary) do
    parse_unsigned(binary)
  end

  defp parse_unsigned(<<digit, rest::binary>>) when digit in ?0..?9 do
    # IO.inspect(binding(), label: "### binding 1 digit")

    parse_unsigned(rest, false, false, <<digit>>)
  end

  defp parse_unsigned(binary) when is_binary(binary), do: :error

  defp parse_unsigned(<<digit, rest::binary>>, dot?, e?, acc) when digit in ?0..?9 do
    # IO.inspect(binding(), label: "### binding ?? E ")

    parse_unsigned(rest, dot?, e?, <<acc::binary, digit>>)
  end

  defp parse_unsigned(<<?., digit, rest::binary>>, false, false, acc) when digit in ?0..?9 do
    # IO.inspect(binding(), label: "### binding NO E---")

    parse_unsigned(rest, true, false, <<acc::binary, ?., digit>>)
  end

  defp parse_unsigned(<<exp_marker, digit, rest::binary>>, dot?, false, acc)
       when exp_marker in 'eE' and digit in ?0..?9 do
    # exponent
    exp = String.to_integer(<<digit>>)

    # {112, -2}
    {int_value, decimal_point} = from_parsed_string(acc)

    # new tuple {112, -2+2} = 112 to_string
    new_acc = ApaNumber.to_string({int_value, decimal_point + exp})

    # IO.inspect(binding(), label: "### binding E 1")

    parse_unsigned(rest, true, true, <<add_dot(new_acc, dot?)::binary, ?e, digit>>)
    # parse_unsigned(rest, false, false, <<add_dot(new_acc, dot?)::binary>>)
  end

  defp parse_unsigned(<<exp_marker, sign, digit, rest::binary>>, dot?, false, acc)
       when exp_marker in 'eE' and sign in '-+' and digit in ?0..?9 do
    # IO.inspect(binding(), label: "### binding E 2")

    parse_unsigned(rest, true, true, <<add_dot(acc, dot?)::binary, ?e, sign, digit>>)
  end

  defp parse_unsigned(rest, _dot?, e?, acc) do
    if e? do
      [d1, d2] =
        acc
        |> String.split(["e", "E"])

      # IO.inspect(binding(), label: "### binding result")

      # d1 "123"
      # d2 "-2"
      d1
    else
      acc
    end

    # {acc, rest}
  end

  defp add_dot(acc, true), do: acc
  defp add_dot(acc, false), do: acc <> ".0"

  @doc """
  create a apa number from a number string - take care about signs, leading and trailing zeros etc.

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

      decimal_point = String.length(d2) * -1

      int_value =
        [d1, d2]
        |> Enum.join()
        |> String.to_integer()

      {int_value, decimal_point}
    else
      int_value = String.to_integer(number_string)
      decimal_point = 0
      {int_value, decimal_point}
    end
  end

  @doc """
  create a string from an apa number

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
  def to_string({int_value, decimal_point}) when decimal_point == 0 do
    Kernel.to_string(int_value)
  end

  def to_string({int_value, decimal_point}) when decimal_point < 0 do
    {d1, d2} =
      Kernel.to_string(int_value)
      |> clean_abs_int_string()
      |> String.split_at(decimal_point)

    sign = minus_sign?(int_value)
    d1_filled = fill_if_empty(d1)
    d2_filled = fill_if_needed(d2, abs(decimal_point))

    "#{sign}#{d1_filled}.#{d2_filled}"
  end

  def to_string({int_value, decimal_point}) when decimal_point > 0 do
    d1_filled =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(decimal_point)

    "#{d1_filled}"
  end

  @doc """
  shift a apa number to another decimal point
  to work with the inetended integer calculation of two numbers with the same decimal point
  this operation do not change the mathematical value:
  ApaNumber.to_string({2, -1}) == "0.2" ~math-equal~ ApaNumber.to_string({20, -2}) == "0.20"
  and always shift_decimal_point > decimal_point because fillup with zeros
  reduce is not intend to implement yet

  ## Examples

      iex> ApaNumber.shift_to({2, -1}, -2)
      {20, -2}

      iex> ApaNumber.shift_to({2, -1}, -4)
      {2000, -4}

  """
  def shift_to({int_value, decimal_point}, shift_decimal_point)
      when decimal_point == shift_decimal_point do
    {int_value, decimal_point}
  end

  def shift_to({int_value, decimal_point}, shift_decimal_point)
      when abs(decimal_point) < abs(shift_decimal_point) do
    new_value =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(abs(shift_decimal_point) - abs(decimal_point))
      |> String.to_integer()

    {new_value, shift_decimal_point}
  end

  def shift_to({_int_value, _decimal_point}, _shift_decimal_point) do
    raise(ArgumentError, "Not implemeted because not needed at the moment - see doc.")
  end

  def minus_sign?(int_value) when int_value < 0 do
    "-"
  end

  def minus_sign?(_int_value) do
    ""
  end

  # def fill_if_empty(int_string) when int_string == "" do
  def fill_if_empty(int_string) when int_string == <<>> do
    fill_up_string_leading_zeros(int_string, 1)
  end

  def fill_if_empty(int_string) do
    int_string
  end

  def fill_if_needed(int_string, abs_decimal_point) when abs_decimal_point >= 0 do
    if String.length(int_string) < abs_decimal_point do
      ApaNumber.fill_up_string_leading_zeros(
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
