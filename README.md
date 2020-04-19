# Apa

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
  - [ ] scale (number of digits after the decimal place in the result)
  - [ ] rounding
  - [ ] Infinity and NaN
  - [ ] string format for result
  - [ ] performance - f.e. benchee check - is this pure Elixir implementation fast enough for normal applications (normal work means not number crunching)

## Installation

  1. Add `apa` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:apa, "~> 0.3.0"}
    ]
  end
  ```

## Usage

  ```elixir

  import Apa
  import Kernel, except: [+: 2, -: 2, *: 2, /: 2, to_string: 1]

  Apa.add("1", "2") # "3"
  Apa.sub("3", "2") # "1"

  price = "3.50 Euro"
  quantity = "12"
  total_string = price * quantity

  ```


## Examples

```elixir
iex> Apa.add("0.1", "0.2")
"0.3"
iex> Apa.sub("3.0", "0.000000000000000000000000000000000000000000000001")
"2.999999999999999999999999999999999999999999999999"
iex> "333.33" |> Apa.add("666.66") |> Apa.sub("111.11")
"888.88"
```
