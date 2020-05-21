defmodule ApaSub do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Subtraction - ApaSub.
  """

  @doc """
  Subtraction - internal function - please call Apa.sub(left, right)
  In reference to bcmath I call this function bc_sub
  """
  @spec bc_sub(term(), term(), integer()) :: String.t()
  def bc_sub(left, right, scale) do
    {left_int, left_exp} = Apa.new(left)
    {right_int, right_exp} = Apa.new(right)

    bc_sub_apa_number({left_int, left_exp}, {right_int, right_exp})
    |> Apa.to_string(scale)
  end

  @spec bc_sub_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_sub_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    ApaAdd.bc_add_apa_number({left_int, left_exp}, {right_int * -1, right_exp})
  end
end
