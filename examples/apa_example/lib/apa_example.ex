defmodule ApaExample do
  @moduledoc """
  Documentation for `ApaExample`.
  """

  @doc """
  Hello Apa.

  ## Examples

      iex> ApaExample.the_answer()
      "42"

  """
  def the_answer do
    the_answer =
      "1"
      |> Apa.add("2")
      |> Apa.add("3")
      |> Apa.sub("4")
      |> Apa.add("5")
      |> Apa.mul("6")

    IO.puts("The Answer to the Ultimate Question of Life, the Universe, and Everything is: ")
    the_answer
  end
end
