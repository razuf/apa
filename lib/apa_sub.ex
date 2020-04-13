defmodule ApaSub do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Subtraction - ApaSub.
  """

  @doc """
  Subtraction - internal function - please call Apa.sub(left, right)
  In reference to bcmath I call this functions bc_sub
  """

  def bc_sub(left, right, scale \\ 0)

  @spec bc_sub(String.t(), String.t(), integer) :: String.t()
  def bc_sub(left, right, scale) when is_binary(left) and is_binary(right) do
    Apa.add(left, ApaNumber.add_minus_sign(right), scale)
  end
end
