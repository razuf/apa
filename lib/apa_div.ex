defmodule ApaDiv do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Division - ApaDiv.
  """

  # used in division to prevent the infinite loop
  @precision_default Application.get_env(:apa, :precision_default, -1)
  @precision_limit if @precision_default == -1, do: 28, else: @precision_default
  # nearly correct limit - 10^308 digits is the limit for erlang :math.log10()
  @max_erlang_math_log 123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789

  @doc """
  Division - internal function - please call Apa.div(left, right)
  """
  @spec bc_div(term(), term(), integer(), integer()) :: String.t()
  def bc_div(left, right, precision, scale) do
    {left_int, left_exp} = Apa.new(left)
    {right_int, right_exp} = Apa.new(right)

    Apa.to_string(
      bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, precision),
      precision,
      scale
    )
  end

  # bc_div_apa_number/2
  @spec bc_div_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, @precision_limit)
  end

  # bc_div_apa_number/3
  @spec bc_div_apa_number({integer(), integer()}, {integer(), integer()}, integer()) ::
          {integer(), integer()}
  def bc_div_apa_number({0, _left_exp}, {0, _right_exp}, _precision) do
    raise(ArgumentError, "Impossible operation - division by zero - 0 / 0 - see doc.")
  end

  def bc_div_apa_number({_left_int, _left_exp}, {0, _right_exp}, _precision) do
    raise(ArgumentError, "Impossible operation - division by zero - divisor == 0 - see doc.")
  end

  def bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, precision) do
    precision_limit = if precision < 0, do: @precision_limit, else: precision

    bc_div_apa_number(
      {left_int, left_exp},
      {right_int, right_exp},
      Kernel.rem(left_int, right_int),
      0,
      precision_limit
    )
  end

  # bc_div_apa_number/5
  defp bc_div_apa_number({left_int, left_exp}, {right_int, right_exp}, 0, _acc, _precision_limit) do
    {Kernel.div(left_int, right_int), left_exp - right_exp}
  end

  defp bc_div_apa_number(
         {left_int, left_exp},
         {right_int, right_exp},
         _rem,
         _acc,
         precision_limit
       ) do
    left_digits = digits_length(abs(left_int))
    right_digits = digits_length(abs(right_int))
    diff_precision = right_digits - left_digits + precision_limit

    {new_left_int, new_left_exp} = shift({left_int, left_exp}, diff_precision)

    {Kernel.div(new_left_int, right_int), new_left_exp - right_exp}
  end

  defp shift({int_value, exp}, pow_value) when pow_value > 0 do
    {int_value * ApaNumber.pow10(pow_value), exp - pow_value}
  end

  defp shift({int_value, exp}, pow_value) when pow_value <= 0 do
    {int_value, exp}
  end

  defp digits_length(0), do: 1

  defp digits_length(int_value) when int_value < @max_erlang_math_log do
    trunc(:math.log10(int_value)) + 1
  end

  defp digits_length(int_value) do
    int_value
    |> Integer.to_string()
    |> Kernel.byte_size()
  end
end
