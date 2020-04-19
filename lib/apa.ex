defmodule Apa do
  @moduledoc """
  Documentation for `Apa`.

  To make it easier to access all functions from one Module
  and to write the code in different files - like ApaAdd, ApaSub etc.
  Maybe there is a better idea - any tip is welcome.

  APA : Arbitrary Precision Arithmetic - pure Elixir implementation.

  For arbitrary precision mathematics - which supports numbers of any size and precision up to a limit of decimals(limit need to be checked - see below TO CHECK:), represented as strings. Inspired by BCMath/PHP.
  This is especially useful when working with floating-point numbers, as these introduce small but in some case significant rounding errors.

  I started this project to learn for myself - so the focus was on learning and have fun!
  But on a short research I found the existing libs have some limits and disadvantages:

  EAPA (Erlang Arbitrary Precision Arithmetic):
  a) Customized precision up to 126 decimal places (current realization)
  Why only 126 decimal places? Apa should not have that limit!
  b) EAPA is a NIF extension written on Rust -> performance fine, but bad in case of dependencies f.e. for nerves

  some limits in standard Erlang/Elixir:
  :math.pow(1.618033988749895, 10000)
  ** (ArithmeticError) bad argument in arithmetic expression

  0.30000000000000004 - 0.30000000000000003
  0.0

  0.1 + 0.2
  0.30000000000000004

  9007199254740992.0 - 9007199254740991.0
  1.0
  9007199254740993.0 - 9007199254740992.0
  0.0
  9007199254740994.0 - 9007199254740993.0
  2.0
  87654321098765432.0 - 87654321098765431.0
  16.0

  0.123456789e-100 * 0.123456789e-100
  1.524157875019052e-202
  0.123456789e-200 * 0.123456789e-200
  0.0

  Later I found Decimal which looks very nice and useful (written by Eric Meadows-Jönsson!) -
  so there is already a solution nice, stable and full featured!
  I used it in Phoenix with Ecto without thinking about it ... but that's life.

  Anyway I had fun on Eastern 2020. ;-)

  A little feature I could offer compared to Decimal (but of course could be easily expanded there too):

  "0.30000000000000004" - "0.30000000000000003"
  "0.00000000000000001"

  or calc and compare directly with strings (ecto/database):

  with Decimal:

  schema "products" do
    field :name, :string
    field :price, :decimal
    timestamps()
  end

  %Product{
    name: "Apple",
    price: 3,
  }
  cart_total = Decimal.to_string(Decimal.mult(Decimal.new(product.price), Decimal.new(cart_quantity)))

  with Apa:

  schema "product" do
    field :name, :string
    field :price, :string
    timestamps()
  end

  %Product{
    name: "Apple",
    price: "3",
  }
  cart_total = product.price * cart_quantity


  ## Features

    A list of supported and planned features (maye incomplete)

    - [x] basic operations (`add`)
    - [x] basic operations (`sub`)
    - [x] basic operations (`mul`)
    - [x] basic operations (`div`)
    - [x] comparison (`comp`)
    - [ ] rounding

  ## Installation

    1. Add `apa` to your list of dependencies in `mix.exs`:


    def deps do
      [
        {:apa, "~> 0.2.0"}
      ]
    end


  ## Usage

    import Apa
    import Kernel, except: [+: 2, -: 2, *: 2, /: 2, to_string: 1]

    Apa.add("1", "2") # "3"
    Apa.sub("3", "2") # "1"

    price = "3.50 Euro"
    quantity = "12"
    total_string = price * quantity

  """

  @doc """
  APA : Arbitrary Precision Arithmetic - Addition

  ## Examples

      iex> Apa.add("1", "2")
      "3"

      iex> Apa.add("1", "-2")
      "-1"

      iex> Apa.add("-1", "2")
      "1"

      iex> Apa.add("-1", "-2")
      "-3"

      iex> Apa.add("999989", "222222")
      "1222211"

      iex> Apa.add("222222", "999989")
      "1222211"

      iex> Apa.add("999", "999989")
      "1000988"

      iex> Apa.add("000000999", "0999989")
      "1000988"

      iex> "1" |> Apa.add("2") |> Apa.add("3.3") |> Apa.add("-3")
      "3.3"

      Compared to standard Elixir - wrong value 6.6!
      iex> 3.30000000000000004 + 3.30000000000000003
      6.6

      Correct with APA:
      iex> Apa.add("3.30000000000000004", "3.30000000000000003")
      "6.60000000000000007"

      iex> Apa.add("3.304","3.300003")
      "6.604003"

      iex> Apa.add("-3.304","-3.300003")
      "-6.604003"

      iex> Apa.add("-3.304","3.300003")
      "-0.003997"

      iex> Apa.add("3.304","-3.300003")
      "0.003997"

      iex> Apa.add("3","3.303")
      "6.303"

      iex> Apa.add("3.303","3")
      "6.303"

      iex> Apa.add("3.303","+003")
      "6.303"

      iex> Apa.add("1","+00120.000")
      "121"

      iex> Apa.add("1.0e2", "1.1")
      "101.1"


  """
  @spec add(String.t(), String.t(), integer) :: String.t()
  def add(left, right, scale \\ 0)

  def add(left, right, scale) do
    ApaAdd.bc_add(left, right, scale)
  end

  def left + right when is_binary(left) and is_binary(right) do
    Apa.add(left, right)
  end

  def {left_int, left_dec} + {right_int, right_dec}
      when is_integer(left_int) and is_integer(left_dec) and is_integer(right_int) and
             is_integer(right_dec) do
    ApaAdd.bc_add({left_int, left_dec}, {right_int, right_dec}, 0)
  end

  def left + right do
    Kernel.+(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Subtraction

  ## Examples

      iex> Apa.sub("3", "2")
      "1"

      iex> Apa.sub("2", "3")
      "-1"

      iex> Apa.sub("2", "-3")
      "5"

      iex> Apa.sub("-2", "3")
      "-5"

      iex> "1" |> Apa.sub("2") |> Apa.add("3.30") |> Apa.sub("2.40")
      "-0.1"

      Compared to standard Elixir - wrong value 0.0!
      iex> 3.30000000000000004 - 3.30000000000000003
      0.0

      this is fixed with APA:
      iex> Apa.sub("3.30000000000000004", "3.30000000000000003")
      "0.00000000000000001"

  """
  @spec sub(String.t(), String.t(), integer) :: String.t()
  def sub(left, right, scale \\ 0)

  def sub(left, right, scale) do
    ApaSub.bc_sub(left, right, scale)
  end

  def left - right when is_binary(left) and is_binary(right) do
    Apa.sub(left, right)
  end

  def left - right do
    Kernel.-(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Multiplication

  ## Examples

      iex> Apa.mul("3", "2")
      "6"

      iex> Apa.mul("2", "3")
      "6"

      iex> Apa.mul("2", "-3")
      "-6"

      iex> Apa.mul("-2", "3")
      "-6"

      iex> Apa.mul("-2", "-3")
      "6"

      iex> "1" |> Apa.mul("2") |> Apa.mul("3")
      "6"

  """
  @spec mul(String.t(), String.t(), integer) :: String.t()
  def mul(left, right, scale \\ 0)

  def mul(left, right, scale) do
    ApaMul.bc_mul(left, right, scale)
  end

  def left * right when is_binary(left) and is_binary(right) do
    Apa.mul(left, right)
  end

  def left * right do
    Kernel.*(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Division

  ## Examples

      iex> Apa.div("6", "2")
      "3"

      iex> Apa.div("6", "3")
      "2"

      iex> Apa.div("6", "-3")
      "-2"

      iex> Apa.div("-6", "3")
      "-2"

      iex> Apa.div("-6", "-3")
      "2"

      iex> "18" |> Apa.div("2") |> Apa.div("3")
      "3"

      iex> Apa.div("222.2001", "2222.001")
      "0.1"

  """
  @spec div(String.t(), String.t(), integer) :: String.t()
  def div(left, right, scale \\ 30)

  def div(left, right, scale) do
    ApaDiv.bc_div(left, right, scale)
  end

  def left / right when is_binary(left) and is_binary(right) do
    Apa.div(left, right)
  end

  def left / right do
    Kernel./(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Comparison - ApaComp

  Compares the left_operand to the right_operand and returns the result as an integer.

  left - the left operand, as a string.
  right - the right operand, as a string.
  scale - the optional scale parameter is used to set the number of digits after the decimal place which will be used in the comparison.

  Returns:
   0 if the two operands are equal,
   1 if the left_operand is larger than the right_operand,
   -1 otherwise.

  ## Examples

      iex> Apa.comp("9", "3")
      1

      iex> Apa.comp("3", "9")
      -1

      iex> Apa.comp("999999999999999999999999999","999999999999999999999999999")
      0

      iex> Apa.comp("0","0")
      0

      iex> Apa.comp("+0","-0")
      0

      iex> Apa.comp("-0","-0")
      0

      iex> Apa.comp("+1","-1")
      1

      iex> Apa.comp("1.0","1.0")
      0

      iex> Apa.comp("-1","-1.0")
      0

      Compared to standard Elixir this is fixed with APA - it is -1 !!!
      iex> Apa.comp("12","12.0000000000000001")
      -1

      Compared to standard Elixir this is fixed with APA - it is 1 !!!
      iex> Apa.comp("3.30000000000000004", "3.30000000000000003")
      1

      iex> Apa.comp("1.1", "1.0")
      1

      iex> Apa.comp("1.0", "1.1")
      -1

  """
  def comp(left, right) do
    ApaComp.bc_comp(left, right)
  end

  @doc """
  Normal Elixir Comparison adapted to strings to use for tests with ApaComp

  Compares the left_operand to the right_operand and returns the result as an integer.

  left - the left operand, as a string.
  right - the right operand, as a string.
  scale - the optional scale parameter is used to set the number of digits after the decimal place which will be used in the comparison.

  Returns:
   0 if the two operands are equal,
   1 if the left_operand is larger than the right_operand,
   -1 otherwise.

  ## Examples

      iex> Apa.elixir_comp("9", "3")
      1

      iex> Apa.elixir_comp("999999999999999999999999999","999999999999999999999999999")
      0

      iex> Apa.elixir_comp("0","0")
      0

      iex> Apa.elixir_comp("+0","-0")
      0

      iex> Apa.elixir_comp("-0","-0")
      0

      iex> Apa.elixir_comp("+1","-1")
      1

      iex> Apa.elixir_comp("1","1.0")
      0

      iex> Apa.elixir_comp("-1","-1.0")
      0

      Wrong in normal Elixir - (it should be -1):
      iex> Apa.elixir_comp("12","12.0000000000000001")
      0

      or adapted to another common calc = wrong too! (it sould be 1):
      iex> Apa.elixir_comp("3.30000000000000004", "3.30000000000000003")
      0

      iex> Apa.elixir_comp("1.0", "1.1")
      -1

  """
  def elixir_comp(left, right) do
    ApaComp.elixir_comp(left, right)
  end
end
