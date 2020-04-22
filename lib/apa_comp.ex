defmodule ApaComp do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Comparision - ApaComp.
  """

  @doc """
  Comparison - internal function - please call Apa.comp(left, right)
  In reference to bcmath I call this function bc_comp
  """
  @spec bc_comp(String.t(), String.t()) :: integer() | Exception
  def bc_comp(left, right) do
    cond do
      ApaNumber.from_string(Apa.sub(left, right)) == {0, 0} -> 0
      String.first(Apa.sub(left, right)) == "-" -> -1
      true -> 1
    end
  end
end
