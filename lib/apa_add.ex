defmodule ApaAdd do
  @moduledoc """
  Documentation for `ApaAdd`.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right)
  In reference to bcmath I call this functions bc_add

  ## Examples

      iex> Apa.bc_add("1", "2")
      "3"

  """
  def bc_add(left, right) do
    # placeholder to test generell structure
    to_string(String.to_integer(left) + String.to_integer(right))
  end
end
