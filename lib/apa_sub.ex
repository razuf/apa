defmodule ApaSub do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Subtraction - ApaSub.
  """

  @doc """
  Subtraction - internal function - please call Apa.sub(left, right)
  In reference to bcmath I call this function bc_sub
  """
  @spec bc_sub(String.t(), String.t(), integer()) :: String.t() | Exception
  def bc_sub(left, right, scale) when is_binary(left) and is_binary(right) do
    Apa.add(left, ApaNumber.add_minus_sign(right), scale)
  end

  def bc_sub(left, right, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    scale: #{inspect(scale)}
    ")
  end

  @spec bc_sub_apa_number({integer(), integer()}, {integer(), integer()}, integer()) :: String.t()
  def bc_sub_apa_number({left_int, left_dec}, {right_int, right_dec}, _scale) do
    ApaAdd.bc_add_apa_number({left_int, left_dec}, {right_int * -1, right_dec}, 0)
  end
end
