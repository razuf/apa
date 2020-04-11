defmodule ApaNumber do
  @moduledoc """
  Documentation for `ApaNumber`.
  APA : Arbitrary Precision Arithmetic - Number String helper - ApaNumber.

  Helper for all needs to handle number strings input

  I start with easy stuff clean, fill_up etc.
  Later maybe I'll use a parser to handle more complex inputs
  """

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
      clean_float_string(number_string)
    else
      clean_int_string(number_string)
    end
  end

  def clean_int_string(int_string) do
    int_string
    |> String.trim_leading("+")
    |> String.trim_leading("-")
    |> String.trim_leading("0")
  end

  def clean_float_string(float_string) do
    float_string
    |> String.trim_leading("+")
    |> String.trim_leading("-")
    |> String.trim_leading("0")
    |> String.trim_trailing("0")
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
