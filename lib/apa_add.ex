defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right)
  In reference to bcmath I call this functions bc_add
  """
  @spec bc_add(String.t(), String.t(), integer()) :: String.t()
  def bc_add(left, right, scale \\ 0)

  def bc_add(left, right, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_dec} = ApaNumber.from_string(left)
    {right_int, right_dec} = ApaNumber.from_string(right)

    bc_add_apa_number({left_int, left_dec}, {right_int, right_dec}, scale)
  end

  def bc_add(left, right, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    scale: #{inspect(scale)}
    ")
  end

  @spec bc_add_apa_number({integer(), integer()}, {integer(), integer()}, integer()) :: String.t()
  def bc_add_apa_number({left_int, left_dec}, {right_int, right_dec}, _scale)
      when left_dec < right_dec do
    {shifted_right_int, shifted_dec} = ApaNumber.shift_to({right_int, right_dec}, left_dec)

    ApaNumber.to_string({left_int + shifted_right_int, shifted_dec})
  end

  def bc_add_apa_number({left_int, left_dec}, {right_int, right_dec}, _scale)
      when left_dec > right_dec do
    {shifted_left_int, shifted_dec} = ApaNumber.shift_to({left_int, left_dec}, right_dec)

    ApaNumber.to_string({shifted_left_int + right_int, shifted_dec})
  end

  def bc_add_apa_number({left_int, left_dec}, {right_int, _right_dec}, _scale) do
    ApaNumber.to_string({left_int + right_int, left_dec})
  end
end
