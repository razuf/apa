defmodule ApaComp do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Comparision - ApaComp.
  """

  @doc """
  Comparison - internal function - please call Apa.comp(left, right, sclae, precision)
  The 'precision' of an ApaNumber is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
  The 'scale' of an ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point
  """
  @spec bc_comp(String.t(), String.t(), integer(), integer()) :: integer() | Exception
  def bc_comp(left, right, precision, scale) do
    diff = Apa.sub(left, right, precision, scale)

    cond do
      Apa.from_string(diff) == {0, 0} -> 0
      String.first(diff) == "-" -> -1
      true -> 1
    end
  end
end
