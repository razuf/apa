defmodule ApaMul do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Multiplication - ApaMul.
  """

  @doc """
  Multiplication - internal function - please call Apa.mul(left, right)
  In reference to bcmath I call this functions bc_mul
  """

  def bc_mul(left, right, scale \\ 0)

  @spec bc_mul(String.t(), String.t(), integer) :: String.t()
  def bc_mul(left, right, scale) when is_binary(left) and is_binary(right) do
    to_string(String.to_integer(left) * String.to_integer(right))
  end
end
