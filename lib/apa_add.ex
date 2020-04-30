defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right)
  In reference to bcmath I call this function bc_add
  """
  @spec bc_add(String.t(), String.t(), integer(), integer()) :: String.t()
  def bc_add(left, right, precision, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_dec} = ApaNumber.from_string(left)
    {right_int, right_dec} = ApaNumber.from_string(right)

    ApaNumber.to_string(
      bc_add_apa_number({left_int, left_dec}, {right_int, right_dec}),
      precision,
      scale
    )
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
  def bc_add_apa_number({left_int, left_dec}, {right_int, right_dec})
      when left_dec < right_dec do
    {shifted_right_int, shifted_dec} = ApaNumber.shift_to({right_int, right_dec}, left_dec)

    {left_int + shifted_right_int, shifted_dec}
  end

  def bc_add_apa_number({left_int, left_dec}, {right_int, right_dec})
      when left_dec > right_dec do
    {shifted_left_int, shifted_dec} = ApaNumber.shift_to({left_int, left_dec}, right_dec)

    {shifted_left_int + right_int, shifted_dec}
  end

  def bc_add_apa_number({left_int, left_dec}, {right_int, _right_dec}) do
    {left_int + right_int, left_dec}
  end
end
