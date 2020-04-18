defmodule ApaDiv do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Division - ApaDiv.
  """

  @doc """
  Division - internal function - please call Apa.div(left, right)
  In reference to bcmath I call this functions bc_div
  """

  def bc_div(left, right, scale \\ 0)

  @spec bc_div(String.t(), String.t(), integer) :: String.t()
  def bc_div(left, right, scale) when is_binary(left) and is_binary(right) do
    to_string(div(String.to_integer(left), String.to_integer(right)))
  end
end
