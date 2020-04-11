defmodule ApaSub do
  @moduledoc """
  Documentation for `ApaSub`.
  """

  @doc """
  Subtraction - internal function - please call Apa.sub(left, right)
  In reference to bcmath I call this functions bc_sub

  ## Examples

      iex> Apa.sub("3", "2")
      "1"

  """
  def bc_sub(left, right) do
    # placeholder to test generell structure
    to_string(String.to_integer(left) - String.to_integer(right))
  end
end
