defmodule ApaMul do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Multiplication - ApaMul.
  """

  @doc """
  Multiplication - internal function - please call Apa.mul(left, right)
  In reference to bcmath I call this function bc_mul
  """
  @spec bc_mul(String.t(), String.t(), integer) :: String.t() | Exception
  def bc_mul(left, right, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_exp} = ApaNumber.from_string(left)
    {right_int, right_exp} = ApaNumber.from_string(right)

    bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp}, scale)
  end

  def bc_mul(left, right, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    scale: #{inspect(scale)}
    ")
  end

  @spec bc_mul_apa_number({integer(), integer()}, {integer(), integer()}, integer()) :: String.t()
  def bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp}, _scale) do
    ApaNumber.to_string({left_int * right_int, left_exp + right_exp})
  end
end
