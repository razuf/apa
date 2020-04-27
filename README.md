# Apa

![Elixir CI status](https://github.com/razuf/apa/workflows/Elixir%20CI/badge.svg)&nbsp;[![codecov](https://codecov.io/gh/razuf/apa/branch/master/graph/badge.svg)](https://codecov.io/gh/razuf/apa)&nbsp;[![hex.pm version](https://img.shields.io/hexpm/v/apa.svg)](https://hex.pm/packages/apa)&nbsp;[![hexdocs.pm](https://img.shields.io/badge/docs-latest-green.svg?style=flat-square)](https://hexdocs.pm/apa/)

APA : Arbitrary Precision Arithmetic - pure Elixir implementation.

![Apa](/priv/apa_logo.png)

For arbitrary precision mathematics - which supports numbers of any size and precision up to nearly unlimited of decimals (internal Elixir integer math), represented as strings. This is especially useful when working with floating-point numbers, as these introduce small but in some case significant rounding errors.

## Intention, Pros & Cons

I started this project to learn for myself - so the focus was on learning and have fun!

You could use it if you like - there are some test coverage - but for production I would recommend the [Decimal](https://github.com/ericmj/decimal) package!

The basic idea is to work with strings (inspired by BCMath/PHP):

- parse/convert any string into internal ApaNumber - a tuple: {integer_value, exponent}
- calculate with that tuple
- reconvert it with **to_string** function

Some limits and 'bugs' in standard Erlang/Elixir:

```elixir
iex> 0.30000000000000004 - 0.30000000000000003
0.0
```

with Apa:

```elixir
"0.30000000000000004" - "0.30000000000000003"
"0.00000000000000001"
```

Elixir:

```elixir
iex> 0.1 + 0.2
0.30000000000000004
```

with Apa:

```elixir
"0.1" + "0.2"
"0.3"
```

Elixir:

```elixir
iex> 9007199254740992.0 - 9007199254740991.0
1.0
iex> 9007199254740993.0 - 9007199254740992.0
0.0
iex> 9007199254740994.0 - 9007199254740993.0
2.0

iex> 87654321098765432.0 - 87654321098765431.0
16.0

iex> 0.123456789e-100 * 0.123456789e-100
1.524157875019052e-202
iex> 0.123456789e-200 * 0.123456789e-200
0.0

iex> :math.pow(2, 1500)
** (ArithmeticError) bad argument in arithmetic expression
```

On a short research I found the existing lib EAPA have some limits and disadvantages:

[EAPA](https://github.com/Vonmo/eapa) (Erlang/Elixir Arbitrary-Precision Arithmetic)
a) Customized precision up to 126 decimal places (current realization)
Why only 126 decimal places? Apa should not have that limit!

b) EAPA is a NIF extension written on Rust -> performance fine, but bad in case of dependencies f.e. for [Nerves](https://www.nerves-project.org/).
Apa is in pure Elixir with no dependency - running on any [Nerves device](https://hexdocs.pm/nerves/targets.html/).

Later I found [Decimal](https://github.com/ericmj/decimal) which looks very nice and useful (written by Eric Meadows-Jönsson!) - so there is already a solution - nice, stable and full featured!
I used it in Phoenix with Ecto without thinking about it ... but that's life.

Anyway I had fun with Apa on Eastern 2020. ;-)

A little feature I could offer compared to [Decimal](https://github.com/ericmj/decimal) (but of course could be easily expanded there too)

```elixir
"0.30000000000000004" - "0.30000000000000003"
"0.00000000000000001"
```

Or calc and compare directly with strings in case of ecto/database

with Decimal:

```elixir
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
```

with Apa:

```elixir
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
```

Could be useful with [CubDB](https://github.com/lucaong/cubdb) (pure Elixir key/value database).

## Cons

Slower performance compared to original Elixir integer or float calculation (see raw performance tests).

## Precision and Scale

Some ideas come from Postgres and I extend that to be useful in Elixir:

The 'precision' of an ApaNumber is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
The 'scale' of an ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point
So the number 123.456 has a precision of 6 and a scale of 3. Integers can be considered to have a scale of 0.

### No explixit precision and no explicit scale

All operations (except the division - see below) without any explicit precision or scale workes up to the implementation limit on elixir integer. An ApaNumber of this kind will not coerce input values to any particular scale.

The division is limited in this case by the default scale value (see config), otherwise there will be very often huge nearly endless strings (f.e. 10/3). If you need any higher precision/scale you could adjust the default value (see config) or use the precision and/or scale parameter for each operation.

## Features

  A list of supported and planned features (maybe incomplete)

  - [x] basic operations (`add`)
  - [x] basic operations (`sub`)
  - [x] basic operations (`mul`)
  - [x] basic operations (`div`)
  - [x] comparison (`comp`)
  - [ ] precision (total count of significant digits)
  - [ ] scale (number of digits after the decimal place)
  - [ ] rounding
  - [ ] Infinity and NaN
  - [ ] string format for result
  - [ ] performance - f.e. benchee check - this pure Elixir implementation looks like fast enough for normal applications (normal means not for number crunching)

## Installation

  1. Add `apa` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:apa, "~> 0.4.0"}
    ]
  end
  ```

## Usage

  ```elixir
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
  ```

## Examples

```elixir
iex> Apa.add("0.1", "0.2")
"0.3"
iex> Apa.sub("3.0", "0.000000000000000000000000000000000000000000000001")
"2.999999999999999999999999999999999999999999999999"
iex> "333.33" |> Apa.add("666.66") |> Apa.sub("111.11")
"888.88"

iex> "1" |> Apa.add("2") |> Apa.add("3") |> Apa.sub("4") |> Apa.add("5") |> Apa.mul("6")
"42"
```

:laughing:
