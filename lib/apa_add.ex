defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right, precision, scale)
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
    int_value = left_int + right_int * ApaNumber.pow10(right_exp - left_exp)
    {int_value, left_exp}
  end

  def bc_add_apa_number({left_int, left_exp}, {right_int, right_exp})
      when left_exp > right_exp do
    int_value = left_int * ApaNumber.pow10(left_exp - right_exp) + right_int
    {int_value, right_exp}
  end

  def bc_add_apa_number({left_int, left_exp}, {right_int, _right_exp}) do
    {left_int + right_int, left_exp}
  end
end
