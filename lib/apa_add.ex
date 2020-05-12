defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right, precision, scale)
  In reference to bcmath I call this function bc_add
  """

  @spec bc_add(term(), term(), integer(), integer()) :: String.t()
  def bc_add(left, right, precision, scale) do
    {left_int, left_exp} = Apa.new(left)
    {right_int, right_exp} = Apa.new(right)

    bc_add_apa_number({left_int, left_exp}, {right_int, right_exp})
    |> Apa.to_string(precision, scale)
  end

  @spec bc_add_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_add_apa_number({left_int, left_exp}, {right_int, right_exp})
      when left_exp < right_exp do
    {shifted_right_int, shifted_exp} = ApaNumber.shift_to({right_int, right_exp}, left_exp)
    {left_int + shifted_right_int, shifted_exp}
  end

  def bc_add_apa_number({left_int, left_exp}, {right_int, right_exp})
      when left_exp > right_exp do
    {shifted_left_int, shifted_exp} = ApaNumber.shift_to({left_int, left_exp}, right_exp)
    {shifted_left_int + right_int, shifted_exp}
  end

  def bc_add_apa_number({left_int, left_exp}, {right_int, _right_exp}) do
    {left_int + right_int, left_exp}
  end
end
