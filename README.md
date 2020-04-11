# Apa

APA : Arbitrary Precision Arithmetic - pure Elixir implementation.

For arbitrary precision mathematics - which supports numbers of any size and precision up to a limit of decimals(limit need to be checked - see below TO CHECK:), represented as strings. Inspired by BCMath/PHP.

https://hex.pm/packages/apa

## Features

An incomplete list of supported and planned features

 - [ ] basic operations (`add`, `sub`, `mul`, `div` )
 - [ ] exponentiation (`comp`)
 - [ ] exponentiation (`mod`)
 - [ ] exponentiation (`pow`)

## Installation

  1. Add `apa` to your list of dependencies in `mix.exs`:


```elixir
def deps do
  [
    {:apa, "~> 0.1.0"}
  ]
end
```

## Usage

```left = "123"
right = "456"
Apa.add(left, right)
```

### Examples

```elixir
iex> Apa.add("0.1", "0.2")
"0.3"
iex> Apa.sub("3.0", "0.000000000000000000000000000000000000000000000001")
"2.999999999999999999999999999999999999999999999999"
iex> "333.33" |> Apa.add("666.66") |> Apa.sub("111.11")
"888.88"
```

## TO CHECK:

- performance - f.e. benchee check - is this pure Elixir implementation fast enough for normal applications (normal work means not number crunching)
- limit of precision decimals
- 