defmodule ApaMul do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Multiplication - ApaMul.
  """

  @doc """
  Multiplication - internal function - please call Apa.mul(left, right)
  In reference to bcmath I call this function bc_mul
  """
  @spec bc_mul(term(), term(), integer(), integer()) :: String.t()
  def bc_mul(left, right, precision, scale) do
    {left_int, left_exp} = Apa.new(left)
    {right_int, right_exp} = Apa.new(right)

    bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp})
    |> Apa.to_string(precision, scale)
  end

  @spec bc_mul_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    {left_int * right_int, left_exp + right_exp}
  end
end
