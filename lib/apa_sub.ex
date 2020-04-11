defmodule ApaSub do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Subtraction - ApaSub.
  """

  @doc """
  Subtraction - internal function - please call Apa.sub(left, right)
  In reference to bcmath I call this functions bc_sub
  """

  def bc_sub(left, right) do
    # placeholder to test general structure
    to_string(String.to_integer(left) - String.to_integer(right))
  end
end
