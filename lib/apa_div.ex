defmodule ApaDiv do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Division - ApaDiv.
  """

  @doc """
  Division - internal function - please call Apa.div(left, right)
  In reference to bcmath I call this function bc_div
  """
  @spec bc_div(String.t(), String.t(), integer(), integer()) :: String.t()
  def bc_div(left, right, precision, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_exp} = ApaNumber.from_string(left)
    {right_int, right_exp} = ApaNumber.from_string(right)

    bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, precision, scale)
  end

  def bc_div(left, right, precision, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    precision: #{inspect(precision)}
    scale: #{inspect(scale)}
    ")
  end

  @spec bc_div_apa_number({integer(), integer()}, {integer(), integer()}, integer(), integer()) ::
          String.t()
  def bc_div_apa_number({_left_int, _left_exp}, {right_int, _right_exp}, _precision, _scale)
      when right_int == 0 do
    raise(ArgumentError, "Impossible operation - divisor == 0 - see doc.")
  end

  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, precision, scale) do
    bc_div_apa_number(
      {left_int, left_exp},
      {right_int, right_exp},
      precision,
      scale,
      rem(left_int, right_int),
      0
    )
  end

  def bc_div_apa_number(
        {left_int, left_exp},
        {right_int, right_exp},
        precision,
        scale,
        rem,
        _acc
      )
      when rem == 0 do
    ApaNumber.to_string({div(left_int, right_int), left_exp - right_exp}, precision, scale)
  end

  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, precision, scale, _rem, acc)
      when scale == acc do
    ApaNumber.to_string({div(left_int, right_int), left_exp - right_exp}, precision, scale)
  end

  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, precision, scale, _rem, acc) do
    {new_left_int, new_left_exp} = ApaNumber.shift_to({left_int, left_exp}, left_exp - 1)

    bc_div_apa_number(
      {new_left_int, new_left_exp},
      {right_int, right_exp},
      precision,
      scale,
      rem(new_left_int, right_int),
      acc + 1
    )
  end
end
