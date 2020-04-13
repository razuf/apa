defmodule ApaNumber do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Helper to handle number string inputs
  convert any number string to a tuple of 2 integers:
  {integer_value, decimal_point}

  """

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
      {-12012, 2}

      iex> ApaNumber.from_string("-0000120.1200")
      {-12012, 2}

  """
  def from_string(number_string) do
    if String.contains?(number_string, ".") do
      [d1, d2] =
        number_string
        |> clean_float_string()
        |> String.split(".")

      decimal_point = String.length(d2)

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
      "0.003"

      iex> ApaNumber.to_string({-12012, 2})
      "-120.12"

      iex> ApaNumber.to_string({-3997, 6})
      "-0.003997"

  """
  def to_string({int_value, decimal_point}) when decimal_point == 0 do
    Kernel.to_string(int_value)
  end

  def to_string({int_value, decimal_point}) do
    {d1, d2} =
      Kernel.to_string(int_value)
      |> clean_abs_int_string()
      |> String.split_at(-decimal_point)

    sign = minus_sign?(int_value)
    d1_filled = fill_if_empty(d1)
    d2_filled = fill_if_needed(d2, decimal_point)

    "#{sign}#{d1_filled}.#{d2_filled}"
  end

  @doc """
  shift a apa number to another decimal point
  to work with the inetended integer calculation of two numbers with the same decimal point
  this operation do not change the mathematical value:
  ApaNumber.to_string({2, 1}) == "0.2" ~math-equal~ ApaNumber.to_string({20, 2}) == "0.20"
  and always shift_decimal_point > decimal_point because fillup with zeros
  reduce is not intend to implement yet

  ## Examples

      iex> ApaNumber.shift({2, 1}, 2)
      {20, 2}

      iex> ApaNumber.shift({2, 1}, 4)
      {2000, 4}

  """
  def shift({int_value, decimal_point}, shift_decimal_point)
      when decimal_point == shift_decimal_point do
    {int_value, decimal_point}
  end

  def shift({int_value, decimal_point}, shift_decimal_point)
      when decimal_point < shift_decimal_point do
    new_value =
      int_value
      |> Kernel.to_string()
      |> fill_up_string_trailing_zeros(shift_decimal_point - decimal_point)
      |> String.to_integer()

    {new_value, shift_decimal_point}
  end

  def shift({_int_value, _decimal_point}, _shift_decimal_point) do
    raise(ArgumentError, "Not implemeted because not needed at the moment - see doc.")
  end

  def minus_sign?(int_value) when int_value < 0 do
    "-"
  end

  def minus_sign?(_int_value) do
    ""
  end

  def fill_if_empty(int_string) when int_string == "" do
    fill_up_string_leading_zeros(int_string, 1)
  end

  def fill_if_empty(int_string) do
    int_string
  end

  def fill_if_needed(int_string, decimal_point) do
    if String.length(int_string) < decimal_point do
      ApaNumber.fill_up_string_leading_zeros(
        int_string,
        decimal_point - String.length(int_string)
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
