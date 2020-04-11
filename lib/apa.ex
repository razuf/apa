defmodule Apa do
  @moduledoc """
  Documentation for `Apa`.

  I want to make it easier to access all functions from one Module - this Apa module,
  but I want to write the code in different files - like ApaAdd, ApaSub etc.
  Maybe there is a better idea and I find them later - any tip is welcome.

  """

  alias ApaAdd
  alias ApaSub

  @doc """
  Addition

  ## Examples

      iex> Apa.add("1", "2")
      "3"

  """
  def add(left, right) do
    ApaAdd.bc_add(left, right)
  end

  @doc """
  Subtraction

  ## Examples

      iex> Apa.sub("3", "2")
      "1"

  """
  def sub(left, right) do
    ApaSub.bc_sub(left, right)
  end
end
