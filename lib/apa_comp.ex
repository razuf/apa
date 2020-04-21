defmodule ApaComp do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Comparision - ApaComp.
  """

  # import ApaNumber

  @doc """
  Comparison - internal function - please call Apa.comp(left, right)
  In reference to bcmath I call this functions bc_comp
  """
  @spec bc_comp(String.t(), String.t()) :: integer()
  def bc_comp(left, right) when is_binary(left) and is_binary(right) do
    compare_with_different_signs(left, right)
  end

  def bc_comp(left, right) do
    raise(ArgumentError, "No string input:
    left: #{inspect(left)}
    right: #{inspect(right)}
    ")
  end

  defp compare_with_different_signs(left, right) do
    cond do
      ApaNumber.from_string(Apa.sub(left, right)) == {0, 0} -> 0
      String.first(Apa.sub(left, right)) == "-" -> -1
      true -> 1
    end
  end
end
