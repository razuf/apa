defmodule Apa do
  @moduledoc """
  Documentation for `Apa`.

  To make it easier to access all functions from one Module
  and to write the code in different files - like ApaAdd, ApaSub etc.
  Maybe there is a better idea - any tip is welcome.

  APA : Arbitrary Precision Arithmetic - pure Elixir implementation.

  For arbitrary precision mathematics - which supports numbers of any size and precision up to a limit of decimals(limit need to be checked - see below TO CHECK:), represented as strings. Inspired by BCMath/PHP.

  ## Features

  An incomplete list of supported and planned features

  - [ ] basic operations (`add`)
  - [ ] basic operations (`sub`)
  - [ ] basic operations (`mul`)
  - [ ] basic operations (`div`)
  - [ ] exponentiation (`comp`)
  - [ ] exponentiation (`mod`)
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

      iex> Apa.add("999989", "222222")
      "1222211"

      iex> Apa.add("222222", "999989")
      "1222211"

      iex> Apa.add("999", "999989")
      "1000988"

      iex> Apa.add("000000999", "0999989")
      "1000988"

      iex> "1" |> Apa.add("2") |> Apa.add("3") |> Apa.add("4")
      "10"

  """
  def add(left, right) do
    ApaAdd.bc_add(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Subtraction

  ## Examples

      iex> Apa.sub("3", "2")
      "1"

  """
  def sub(left, right) do
    ApaSub.bc_sub(left, right)
  end
end
