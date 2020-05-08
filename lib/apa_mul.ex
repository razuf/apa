defmodule ApaMul do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Multiplication - ApaMul.
  """

  @doc """
  Multiplication - internal function - please call Apa.mul(left, right)
  In reference to bcmath I call this function bc_mul
  """
  @spec bc_mul(String.t(), String.t(), integer(), integer()) :: String.t() | Exception
  def bc_mul(left, right, precision, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_exp} = ApaNumber.from_string(left)
    {right_int, right_exp} = ApaNumber.from_string(right)

    bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp})
    |> ApaNumber.to_string(precision, scale)
  end

  @spec bc_mul({integer(), integer()}, {integer(), integer()}, integer(), integer()) ::
          {integer(), integer()}
  def bc_mul({left_int, left_exp}, {right_int, right_exp}, _precision, _scale)
      when is_integer(left_int) and is_integer(left_exp) and is_integer(right_int) and
             is_integer(right_exp) do
    bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp})
  end

  def bc_mul(left, right, precision, scale) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    precision: #{inspect(precision)}
    scale: #{inspect(scale)}
    ")
  end

  @spec bc_mul_apa_number({integer(), integer()}, {integer(), integer()}) ::
          {integer(), integer()}
  def bc_mul_apa_number({left_int, left_exp}, {right_int, right_exp}) do
    {left_int * right_int, left_exp + right_exp}
  end
end
