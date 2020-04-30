defmodule ApaMul do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Multiplication - ApaMul.
  """

  @doc """
  Multiplication - internal function - please call Apa.mul(left, right)
  In reference to bcmath I call this function bc_mul
  """
  @spec bc_mul(String.t(), String.t(), integer(), integer()) :: String.t() | Exception
  def bc_mul(left, right, precision, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_exp} = ApaNumber.from_string(left)
    {right_int, right_exp} = ApaNumber.from_string(right)

    ApaNumber.to_string(
      bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp}),
      precision,
      scale
    )
  end

  def bc_mul(left, right, precision, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    precision: #{inspect(precision)}
    scale: #{inspect(scale)}
    ")
  end

  @spec bc_mul_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    {left_int * right_int, left_exp + right_exp}
  end
end
