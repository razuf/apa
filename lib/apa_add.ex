defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right, precision, scale)
  In reference to bcmath I call this function bc_add
  """
  @spec bc_add(String.t(), String.t(), integer(), integer()) :: String.t()
  def bc_add(left, right, precision, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_exp} = ApaNumber.from_string(left)
    {right_int, right_exp} = ApaNumber.from_string(right)

    bc_add_apa_number({left_int, left_exp}, {right_int, right_exp})
    |> ApaNumber.to_string(precision, scale)
  end

  @spec bc_add({integer(), integer()}, {integer(), integer()}, integer(), integer()) ::
          {integer(), integer()}
  def bc_add({left_int, left_exp}, {right_int, right_exp}, _precision, _scale)
      when is_integer(left_int) and is_integer(left_exp) and is_integer(right_int) and
             is_integer(right_exp) do
    bc_add_apa_number({left_int, left_exp}, {right_int, right_exp})
  end

  def bc_add(left, right, precision, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    precision: #{inspect(precision)}
    scale: #{inspect(scale)}
    ")
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
