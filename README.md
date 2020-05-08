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

b) EAPA is a NIF extension written on Rust -> performance fine, but bad in case of strong dependencies.
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

Could be useful together with [CubDB](https://github.com/lucaong/cubdb) (pure Elixir key/value database) f.e. in a [Nerves environment](https://www.nerves-project.org/).

## Cons

Not heavy tested in production so there are probably many uncovered issues.

Slower performance compared to original Elixir integer or float calculation (see performance comparision in tests and benchee benchmarks in examples).


## Installation

  1. Add `apa` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:apa, "~> 0.6"}
    ]
  end
  ```

## Config

Default values for precision and scale - you don't need to put it in your config, only if you want to overwrite it.

config/config.exs:

```elixir
use Mix.Config

# Configures the apa precision and scale defaults
# scale < 0 (default -1) - no touch on decimal point
# scale == 0 - always integer
# scale > 0 - always make a decimal point at scale
# precision <= 0 - (default -1) - no touch at the precision == arbitrary precision
# precision > 0 - the total count of significant digits in the whole number
# you can overwrite the defaults with the  following or ues explicit precision and/or scale
config :apa,
  precision_default: -1,
  scale_default: -1
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

## Examples (see examples folder too)

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

## Performance comparison with Decimal - fortunately it's 'a little' faster and lower memory consumption

[More benchmark results (f.e.linux ), other tests and infos.](https://github.com/razuf/apa/blob/master/examples/apa_example/benchee/bench_results.md).

Benchee script in examples folder - [bench_apa_short.exs](https://github.com/razuf/apa/blob/master/examples/apa_example/benchee/bench_apa_short.exs):

```elixir
inputs = %{
  "606 Digits Integer as String" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
}

bench = %{
  "Decimal.add() Int" => fn {l, r} ->
    Decimal.add(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  end,
  "Apa.add() Int" => fn {l, r} ->
    Apa.add({l, 0}, {r, 0})
  end,
  "Decimal.add() Dec" => fn {l, r} ->
    Decimal.add(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  end,
  "Apa.add() Dec" => fn {l, r} ->
    Apa.add({l, -12}, {r, 12})
  end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 1,
  memory_time: 1,
  print: [fast_warning: false]
)
```

```
##### With input 606 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int         2987.35 K        0.33 μs  ±7486.92%           0 μs           1 μs
Apa.add() Dec          628.08 K        1.59 μs   ±131.47%           2 μs           2 μs
Decimal.add() Int       46.63 K       21.44 μs    ±26.49%          21 μs          37 μs
Decimal.add() Dec       43.02 K       23.24 μs    ±25.11%          22 μs          44 μs

Comparison: 
Apa.add() Int         2987.35 K
Apa.add() Dec          628.08 K - 4.76x slower +1.26 μs
Decimal.add() Int       46.63 K - 64.06x slower +21.11 μs
Decimal.add() Dec       43.02 K - 69.44x slower +22.91 μs

Memory usage statistics:

Name                 Memory usage
Apa.add() Int           0.0703 KB
Apa.add() Dec           0.0938 KB - 1.33x memory usage +0.0234 KB
Decimal.add() Int         2.25 KB - 32.00x memory usage +2.18 KB
Decimal.add() Dec         1.38 KB - 19.56x memory usage +1.30 KB
```

## Precision and Scale

Some ideas come from Postgres and I extend that to be useful in Elixir:

The 'precision' of an ApaNumber is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
The 'scale' of an ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point.
So the number 123.456 has a precision of 6 and a scale of 3. A scale of 0 will effect as Integer.

scale < 0 (default -1) - no touch on decimal point, when it is there or not - with a limit of 321 if its unlimited/periodic flow of numbers like 10/3 = 0.333333... - if you want more digits after the decimal point you can overwrite it with an explicit value for scale > 0 see below
scale == 0 - always integer -> "1.1" with a scale of 0 will be "1"
scale > 0 - always make a decimal point with the amount of scale  -> "1" with scale of 3 will be "1.000"

precision <= 0 - means no touch at the precision - arbitrary precision as possible maybe limited by scale
precision > 0 - the total count of significant digits in the whole number - if the precision is less then the real significant digits it will be replaced by 0 without rounding: 123.456 with a precision of 5 will be returned as 123.450

### No explicit precision and no explicit scale

All operations (except the division - see below) without any explicit precision or scale works up to the implementation limit on elixir integer. An ApaNumber of this kind will not coerce input values to any particular scale. Implemented with default value of precision -1 and default value of scale -1. These defaults can be overwritten via config.

The division is limited in this case by the default scale value (see config), otherwise there will be very often huge nearly endless strings (f.e. 10/3 = 0.3333...). If you need any higher precision/scale you could adjust the default value (via config) or use the precision and/or scale parameter for each operation.

```elixir
iex> Apa.add("0.12", "0.34")
"0.46"

iex> Apa.div("10", "3")
"3.333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333"

otherwise:
iex> Apa.div("10", "3", -1, 12)
"3.333333333333"
```

### Explicit precision and/or explicit scale

Both the precision and the scale of an ApaNumber can be configured as maximum values.
That means ApaNumbers with a declared precision and/or scale will coerce input values to that precision/scale.
The precision must be positive, the scale zero or positive.

```elixir
iex> Apa.add("0.1", "0.2", -1, 3)
"0.300"

iex> Apa.add("1001", "2002", 3, -1)
"3000"

iex> Apa.add("12.34", "43.21", 4, 2)
"55.55"

iex> Apa.add("12.34", "43.21", 3, 2)
"55.50"

iex> Apa.add("12.34", "43.21", 3, 0)
"55"

iex> Apa.mul("3.50 Euro", "12 Stück", -1, 2)
"42.00"
```

## Features

  A list of supported and planned features (maybe incomplete)

  - [x] basic operations (`add`)
  - [x] basic operations (`sub`)
  - [x] basic operations (`mul`)
  - [x] basic operations (`div`)
  - [x] comparison (`comp`)
  - [x] precision (total count of significant digits)
  - [x] scale (number of digits after the decimal place)
  - [x] config for precision and scale defaults
  - [x] NaN and Infinity - (my decision is: Don't use NaN and Infinity - see below)
  - [ ] string format for result
  - [ ] rounding
  - [ ] performance - f.e. benchee check - this pure Elixir implementation looks like fast enough for normal applications (normal means not for number crunching)

## NaN and Infinity

I don't use NaN and Infinity because I think its more clear and strait forward to handle division by zero with an error/exception, because it makes no sense at all to continue with any operation after a division by zero - see [Wikipedia Division_by_zero](https://en.wikipedia.org/wiki/Division_by_zero). And no other operation in Apa generate a NaN nor an Infinity so I don't use them.

