defmodule ApaComp do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Comparision - ApaComp.
  """

  # import ApaNumber

  @doc """
  Comparison - internal function - please call Apa.comp(left, right)
  In reference to bcmath I call this functions bc_comp
  """
  def bc_comp(left, right) when is_binary(left) and is_binary(right) do
    compare_with_different_signs(left, right)
  end

  def bc_comp(left, right) do
    raise(ArgumentError, "No string input.\n
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

  @doc """
  Comparison - internal function - only for test!!!
  Normal Elixir Comparison adapted to strings to use for tests with ApaComp
  Not very nice implementation
  """
  def elixir_comp(left, right) do
    cond do
      String.contains?(left, ".") and String.contains?(right, ".") ->
        cond do
          String.to_float(left) - String.to_float(right) > 0 -> 1
          String.to_float(left) - String.to_float(right) < 0 -> -1
          String.to_float(left) - String.to_float(right) == 0 -> 0
        end

      String.contains?(left, ".") and not String.contains?(right, ".") ->
        cond do
          String.to_float(left) - String.to_integer(right) > 0 -> 1
          String.to_float(left) - String.to_integer(right) < 0 -> -1
          String.to_float(left) - String.to_integer(right) == 0 -> 0
        end

      not String.contains?(left, ".") and String.contains?(right, ".") ->
        cond do
          String.to_integer(left) - String.to_float(right) > 0 -> 1
          String.to_integer(left) - String.to_float(right) < 0 -> -1
          String.to_integer(left) - String.to_float(right) == 0 -> 0
        end

      not String.contains?(left, ".") and not String.contains?(right, ".") ->
        cond do
          String.to_integer(left) - String.to_integer(right) > 0 -> 1
          String.to_integer(left) - String.to_integer(right) < 0 -> -1
          String.to_integer(left) - String.to_integer(right) == 0 -> 0
        end
    end
  end
end
