defmodule ApaExample do
  import Apa
  import Kernel, except: [+: 2, -: 2, *: 2, /: 2, to_string: 1]

  def the_answer() do
    apa1 = Apa.add("1", "2")
    apa2 = Apa.sub("3", "2")

    price = "3.50 Euro"
    quantity = "12"
    total_string = price * quantity

    IO.puts("The Answer to the Ultimate Question of Life, the Universe, and Everything is: ")

    "1"
    |> Apa.add("2")
    |> Apa.add("3")
    |> Apa.sub("4")
    |> Apa.add("5")
    |> Apa.mul("6")
  end
end
