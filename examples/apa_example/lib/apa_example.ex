defmodule ApaExample do
  import Apa
  import Kernel, except: [+: 2, -: 2, *: 2, /: 2, to_string: 1, abs: 1]

  @doc """
    Test function for profile - see benchee/profile_decimal_add.md
  """
  def profile() do
    # Decimal
    # Decimal.add(123_456_789, 987_654_321)
    Decimal.add(
      %Decimal{sign: 1, coef: 123_456_789, exp: -3},
      %Decimal{sign: 1, coef: 987_654_321, exp: 5}
    )

    # Apa
    # ApaAdd.bc_add_apa_number({123_456_789, -3}, {987_654_321, 5})
    # Apa.add(123_456_789, 987_654_321)
  end

  def the_answer() do
    apa1 = Apa.add("1", "2")
    apa2 = Apa.sub("3", "2")
    IO.puts("apa1: #{apa1} apa2: #{apa2}")

    price = "3.50 Euro"
    quantity = "12"
    total_string = price * quantity
    IO.puts("Total: #{total_string}")

    IO.puts("The Answer to the Ultimate Question of Life, the Universe, and Everything is: ")

    "1"
    |> Apa.add("2")
    |> Apa.add("3")
    |> Apa.sub("4")
    |> Apa.add("5")
    |> Apa.mul("6")
  end
end
