defmodule ApaDiv do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Division - ApaDiv.
  """

  # only used in division when the loop could be inifinite
  @scale_default Application.get_env(:apa, :scale_default, -1)
  @scale_limit if @scale_default == -1, do: 28, else: @scale_default

  @doc """
  Division - internal function - please call Apa.div(left, right)
  In reference to bcmath I call this function bc_div
  """
  @spec bc_div(term(), term(), integer(), integer()) :: String.t()
  def bc_div(left, right, precision, scale) do
    {left_int, left_exp} = Apa.new(left)
    {right_int, right_exp} = Apa.new(right)

    Apa.to_string(
      bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, scale),
      precision,
      scale
    )
  end

  # bc_div_apa_number/2
  @spec bc_div_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, @scale_limit)
  end

  # bc_div_apa_number/3
  @spec bc_div_apa_number({integer(), integer()}, {integer(), integer()}, integer()) ::
          {integer(), integer()}
  def bc_div_apa_number({left_int, _left_exp}, {right_int, _right_exp}, _scale)
      when left_int == 0 and right_int == 0 do
    raise(ArgumentError, "Impossible operation - division by zero - 0 / 0 - see doc.")
  end

  def bc_div_apa_number({_left_int, _left_exp}, {right_int, _right_exp}, _scale)
      when right_int == 0 do
    raise(ArgumentError, "Impossible operation - division by zero - divisor == 0 - see doc.")
  end

  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, scale) do
    scale_limit = if scale < 0, do: @scale_limit, else: scale

    bc_div_apa_number(
      {left_int, left_exp},
      {right_int, right_exp},
      Kernel.rem(left_int, right_int),
      0,
      scale_limit
    )
  end

  # bc_div_apa_number/5
  defp bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, 0, _acc, _scale_limit) do
    {Kernel.div(left_int, right_int), left_exp - right_exp}
  end

  defp bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, _rem, acc, scale_limit)
       when left_exp == -scale_limit do
    {Kernel.div(left_int, right_int), left_exp - right_exp}
  end

  defp bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, _rem, acc, scale_limit) do
    {new_left_int, new_left_exp} = shift({left_int, left_exp})

    bc_div_apa_number(
      {new_left_int, new_left_exp},
      {right_int, right_exp},
      Kernel.rem(new_left_int, right_int),
      acc + 1,
      scale_limit
    )
  end

  defp shift({int_value, exp}) do
    {int_value * 10, exp - 1}
  end
end
