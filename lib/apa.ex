defmodule Apa do
  @moduledoc """
  Documentation for `Apa`.

  To make it easier to access all functions from one Module
  and to write the code in different files - like ApaAdd, ApaSub etc.
  Maybe there is a better idea - any tip is welcome.

  APA : Arbitrary Precision Arithmetic - pure Elixir implementation.

  For arbitrary precision mathematics - which supports numbers of any size and precision up to a limit of decimals(limit need to be checked - see below TO CHECK:), represented as strings. Inspired by BCMath/PHP.
  This is especially useful when working with floating-point numbers, as these introduce small but in some case significant rounding errors.

  ## Features

    An incomplete list of supported and planned features

    - [x] basic operations (`add`)
    - [x] basic operations (`sub`)
    - [ ] basic operations (`mul`)
    - [ ] basic operations (`div`)
    - [ ] comparison (`comp`)
    - [ ] exponentiation (`pow`)

  ## Installation

    1. Add `apa` to your list of dependencies in `mix.exs`:


    def deps do
      [
        {:apa, "~> 0.1.0"}
      ]
    end


  ## Usage

    Apa.add("123", "456")

  """

  alias ApaAdd
  alias ApaSub

  @doc """
  APA : Arbitrary Precision Arithmetic - Addition

  ## Examples

      iex> Apa.add("1", "2")
      "3"

      iex> Apa.add("1", "-2")
      "-1"

      iex> Apa.add("-1", "2")
      "1"

      iex> Apa.add("-1", "-2")
      "-3"

      iex> Apa.add("999989", "222222")
      "1222211"

      iex> Apa.add("222222", "999989")
      "1222211"

      iex> Apa.add("999", "999989")
      "1000988"

      iex> Apa.add("000000999", "0999989")
      "1000988"

      iex> "1" |> Apa.add("2") |> Apa.add("3.3") |> Apa.add("-3")
      "3.3"

      iex> Apa.add("3.30000000000000004", "3.30000000000000003")
      "6.60000000000000007"

      iex> Apa.add("3.304","3.300003")
      "6.604003"

      iex> Apa.add("-3.304","-3.300003")
      "-6.604003"

      iex> Apa.add("-3.304","3.300003")
      "-0.003997"

      iex> Apa.add("3.304","-3.300003")
      "0.003997"

      iex> Apa.add("3","3.303")
      "6.303"

      iex> Apa.add("3.303","3")
      "6.303"

      iex> Apa.add("3.303","+003")
      "6.303"

      iex> Apa.add("1","+00120.000")
      "121"

  """
  @spec add(String.t(), String.t(), integer) :: String.t()
  def add(left, right, scale \\ 0)

  def add(left, right, scale) do
    ApaAdd.bc_add(left, right, scale)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Subtraction

  ## Examples

      iex> Apa.sub("3", "2")
      "1"

      iex> Apa.sub("2", "3")
      "-1"

      iex> Apa.sub("2", "-3")
      "5"

      iex> Apa.sub("-2", "3")
      "-5"

      iex> "1" |> Apa.sub("2") |> Apa.add("3.30") |> Apa.sub("2.40")
      "-0.1"

      iex> Apa.sub("3.30000000000000004", "3.30000000000000003")
      "0.00000000000000001"

  """
  @spec sub(String.t(), String.t(), integer) :: String.t()
  def sub(left, right, scale \\ 0)

  def sub(left, right, scale) do
    ApaSub.bc_sub(left, right, scale)
  end

  @doc """
  Normal Elixir Comparison adapted to strings to use for tests with ApaComp

  Compares the left_operand to the right_operand and returns the result as an integer.

  left - the left operand, as a string.
  right - the right operand, as a string.
  scale - the optional scale parameter is used to set the number of digits after the decimal place which will be used in the comparison.

  Returns:
   0 if the two operands are equal,
   1 if the left_operand is larger than the right_operand,
   -1 otherwise.

  ## Examples

      iex> Apa.elixir_comp?("9", "3")
      1

      iex> Apa.elixir_comp?("999999999999999999999999999","999999999999999999999999999")
      0

      iex> Apa.elixir_comp?("0","0")
      0

      iex> Apa.elixir_comp?("+0","-0")
      0

      iex> Apa.elixir_comp?("-0","-0")
      0

      iex> Apa.elixir_comp?("+1","-1")
      1

      iex> Apa.elixir_comp?("1","1.0")
      0

      iex> Apa.elixir_comp?("-1","-1.0")
      0

      Wrong in normal Elixir - it should be -1:
      iex> Apa.elixir_comp?("12","12.0000000000000001")
      0

      or adapted to this:
      iex> Apa.elixir_comp?("3.30000000000000004", "3.30000000000000003")
      0

      iex> Apa.elixir_comp?("1.0", "1.1")
      -1

  """
  def elixir_comp?(left, right) do
    ApaComp.elixir_comp?(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Comparison - ApaComp

  Compares the left_operand to the right_operand and returns the result as an integer.

  left - the left operand, as a string.
  right - the right operand, as a string.
  scale - the optional scale parameter is used to set the number of digits after the decimal place which will be used in the comparison.

  Returns:
   0 if the two operands are equal,
   1 if the left_operand is larger than the right_operand,
   -1 otherwise.

  ## Examples

      iex> Apa.comp?("9", "3")
      1

      iex> Apa.comp?("3", "9")
      -1

      iex> Apa.comp?("999999999999999999999999999","999999999999999999999999999")
      0

      iex> Apa.comp?("0","0")
      0

      iex> Apa.comp?("+0","-0")
      0

      iex> Apa.comp?("-0","-0")
      0

      iex> Apa.comp?("+1","-1")
      1

      # iex> Apa.comp?("1.0","1.0")
      0

      # iex> Apa.comp?("-1","-1.0")
      0

      Fixed here - it is -1 !!!
      # iex> Apa.comp?("12.0000000000000001", "12")
      1

      # iex> Apa.comp?("3.30000000000000004", "3.30000000000000003")
      1

      # iex> Apa.comp?("1.1", "1.0")
      1

      # iex> Apa.comp?("1.0", "1.1")
      -1

  """
  def comp?(left, right) do
    ApaComp.bc_comp?(left, right)
  end
end
