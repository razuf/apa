defmodule ApaAbs do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Absolute Value - ApaAbs.
  """

  @doc """
  Absolute Value - internal function - please call Apa.abs({int, exp})
  In reference to bcmath I call this function bc_abs
  """
  @spec bc_abs({integer(), integer()}) :: {integer(), integer()}
  def bc_abs({int, exp}) when is_integer(int) and is_integer(exp) do
    {Kernel.abs(int), exp}
  end
end
