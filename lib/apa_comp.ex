defmodule ApaComp do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Comparision - ApaComp.
  """

  @doc """
  Comparison - internal function - please call Apa.comp(left, right, scale)
  The 'scale' of an ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point
  In reference to bcmath I call this function bc_comp
  """
  @spec bc_comp(String.t(), String.t(), integer()) :: integer() | Exception
  def bc_comp(left, right, scale) do
    diff = Apa.sub(left, right, scale)

    cond do
      Apa.from_string(diff) == {0, 0} -> 0
      String.first(diff) == "-" -> -1
      true -> 1
    end
  end
end
