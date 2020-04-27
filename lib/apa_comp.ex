defmodule ApaComp do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Comparision - ApaComp.
  """

  @doc """
  Comparison - internal function - please call Apa.comp(left, right, sclae, precision)
  The 'precision' of an ApaNumber is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
  The 'scale' of an ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point
  In reference to bcmath I call this function bc_comp
  """
  @spec bc_comp(String.t(), String.t(), integer(), integer()) :: integer() | Exception
  def bc_comp(left, right, precision, scale) do
    cond do
      ApaNumber.from_string(Apa.sub(left, right, precision, scale)) == {0, 0} -> 0
      String.first(Apa.sub(left, right, precision, scale)) == "-" -> -1
      true -> 1
    end
  end
end
