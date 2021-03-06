defmodule ApaSub do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Subtraction - ApaSub.
  """

  @doc """
  Subtraction - internal function - please call Apa.sub(left, right)
  """
  @spec bc_sub(term(), term(), integer(), integer()) :: String.t()
  def bc_sub(left, right, precision, scale) do
    {left_int, left_exp} = Apa.new(left)
    {right_int, right_exp} = Apa.new(right)

    bc_sub_apa_number({left_int, left_exp}, {right_int, right_exp})
    |> Apa.to_string(precision, scale)
  end

  @spec bc_sub_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_sub_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    ApaAdd.bc_add_apa_number({left_int, left_exp}, {right_int * -1, right_exp})
  end
end
