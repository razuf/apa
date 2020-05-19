## Performance comparison with Decimal - fortunately it's much faster and lower memory

unbelievable - but checked with another environment (linux - VM - see below)
```
##### With input 1 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int            4.95 M      202.03 ns  ±6807.49%           0 ns        1000 ns
Apa.add() Dec            2.71 M      368.75 ns  ±6944.61%           0 ns        1000 ns
Decimal.add() Int        1.36 M      733.04 ns  ±6048.57%        1000 ns        1000 ns
Decimal.add() Dec        0.92 M     1088.82 ns  ±2402.65%        1000 ns        2000 ns

Comparison: 
Apa.add() Int            4.95 M
Apa.add() Dec            2.71 M - 1.83x slower +166.73 ns
Decimal.add() Int        1.36 M - 3.63x slower +531.01 ns
Decimal.add() Dec        0.92 M - 5.39x slower +886.79 ns

Memory usage statistics:

Name                 Memory usage
Apa.add() Int                72 B
Apa.add() Dec                96 B - 1.33x memory usage +24 B
Decimal.add() Int           408 B - 5.67x memory usage +336 B
Decimal.add() Dec           776 B - 10.78x memory usage +704 B

**All measurements for memory usage were the same**

##### With input 15 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int            4.83 M      206.97 ns  ±6629.83%           0 ns        1000 ns
Apa.add() Dec            2.72 M      368.00 ns  ±7830.18%           0 ns        1000 ns
Decimal.add() Int        1.17 M      858.14 ns  ±4299.14%        1000 ns        1000 ns
Decimal.add() Dec        0.45 M     2224.39 ns  ±1095.94%        2000 ns        3000 ns

Comparison: 
Apa.add() Int            4.83 M
Apa.add() Dec            2.72 M - 1.78x slower +161.03 ns
Decimal.add() Int        1.17 M - 4.15x slower +651.17 ns
Decimal.add() Dec        0.45 M - 10.75x slower +2017.42 ns

Memory usage statistics:

Name                 Memory usage
Apa.add() Int                72 B
Apa.add() Dec                96 B - 1.33x memory usage +24 B
Decimal.add() Int           616 B - 8.56x memory usage +544 B
Decimal.add() Dec          2672 B - 37.11x memory usage +2600 B

**All measurements for memory usage were the same**

##### With input 30 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int            3.65 M        0.27 μs ±12009.23%           0 μs           1 μs
Apa.add() Dec            2.25 M        0.44 μs  ±6990.40%           0 μs           1 μs
Decimal.add() Int        0.54 M        1.86 μs  ±1188.87%           2 μs           3 μs
Decimal.add() Dec        0.41 M        2.42 μs   ±780.29%           2 μs           3 μs

Comparison: 
Apa.add() Int            3.65 M
Apa.add() Dec            2.25 M - 1.62x slower +0.171 μs
Decimal.add() Int        0.54 M - 6.78x slower +1.58 μs
Decimal.add() Dec        0.41 M - 8.83x slower +2.14 μs

Memory usage statistics:

Name                 Memory usage
Apa.add() Int           0.0703 KB
Apa.add() Dec           0.0938 KB - 1.33x memory usage +0.0234 KB
Decimal.add() Int         1.73 KB - 24.67x memory usage +1.66 KB
Decimal.add() Dec         3.09 KB - 44.00x memory usage +3.02 KB

**All measurements for memory usage were the same**

##### With input 6 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int            5.01 M      199.53 ns  ±6231.44%           0 ns        1000 ns
Apa.add() Dec            2.68 M      373.42 ns  ±7085.02%           0 ns        1000 ns
Decimal.add() Int        1.35 M      742.98 ns  ±4650.28%        1000 ns        1000 ns
Decimal.add() Dec        0.49 M     2045.55 ns  ±1065.36%        2000 ns        3000 ns

Comparison: 
Apa.add() Int            5.01 M
Apa.add() Dec            2.68 M - 1.87x slower +173.89 ns
Decimal.add() Int        1.35 M - 3.72x slower +543.45 ns
Decimal.add() Dec        0.49 M - 10.25x slower +1846.03 ns

Memory usage statistics:

Name                 Memory usage
Apa.add() Int                72 B
Apa.add() Dec                96 B - 1.33x memory usage +24 B
Decimal.add() Int           472 B - 6.56x memory usage +400 B
Decimal.add() Dec          2672 B - 37.11x memory usage +2600 B

**All measurements for memory usage were the same**

##### With input 60 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int            3.48 M        0.29 μs  ±9887.72%           0 μs           1 μs
Apa.add() Dec            1.85 M        0.54 μs  ±5981.02%           0 μs           1 μs
Decimal.add() Int        0.43 M        2.33 μs   ±894.80%           2 μs           3 μs
Decimal.add() Dec        0.34 M        2.91 μs   ±599.86%           3 μs           5 μs

Comparison: 
Apa.add() Int            3.48 M
Apa.add() Dec            1.85 M - 1.88x slower +0.25 μs
Decimal.add() Int        0.43 M - 8.11x slower +2.05 μs
Decimal.add() Dec        0.34 M - 10.13x slower +2.63 μs

Memory usage statistics:

Name                 Memory usage
Apa.add() Int           0.0703 KB
Apa.add() Dec           0.0938 KB - 1.33x memory usage +0.0234 KB
Decimal.add() Int         2.33 KB - 33.11x memory usage +2.26 KB
Decimal.add() Dec         2.23 KB - 31.78x memory usage +2.16 KB

**All measurements for memory usage were the same**

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

**All measurements for memory usage were the same**
```

and each of the 2.9 Mio results is much more precise (the following operation and result is done by benchee - see bench_apa.exs) :

```elixir
iex(1)> l = 123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901

iex(2)> r = 893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999

iex(3)> Decimal.add(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0)
#Decimal<1.016913578024691357802469136+606>

iex(4)> ApaAdd.bc_add_apa_number({l, 0}, {r, 0})
{1016913578024691357802469135780246913578024691357802469135780246913578024691357802469135780246913578022469135780246913578024691357802469135780246913578024691357802469135780246913578024691357802469135780224691357802469135780246913578024691357802469135780246913578024691357802469135780246913578024691357802246913578024691357802469135780246913578024691357802469135780246913578024691357802469135780246913578022469135780246913578024691357802469135780246913578024691357802469135780246913578024691357802469135780224691357802469135780246913578024691357802469135780246913578024691357802469135780246913578024691357900, 0}
```

## Benchmark suite executing with the following script and configuration:

```elixir
inputs = %{
  "1 Digits Integer as String" => {6, 9},
  "6 Digits Integer as String" => {123_456, 654_321},
  "15 Digits Integer as String" => {123_456_789_012_345, 543_210_987_654_321},
  "30 Digits Integer as String" =>
    {123_456_789_012_345_678_901_234_567_891, 987_654_321_098_765_432_109_876_543_211},
  "60 Digits Integer as String" =>
    {123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891,
     987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211},
  "606 Digits Integer as String" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
}

bench = %{
  # Addition -  Integer values
  "Decimal.add() Int" => fn {l, r} ->
    Decimal.add(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  end,
  "Apa.add() Int" => fn {l, r} ->
    Apa.add({l, 0}, {r, 0})
  end,

  # Addition - Decimalpoint values
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
Operating System: macOS
Elixir 1.10.3
Erlang 22.3.3
warmup: 1 s
time: 6 s
memory time: 1 s
parallel: 1
```

## Linux VM Test

```
Operating System: Linux
CPU Information: QEMU Virtual CPU version 2.5
Number of Available Cores: 1
Available memory: 1.95 GB
Elixir 1.10.3
Erlang 22.3.3

Benchmark suite executing with the following configuration:
warmup: 1 s
time: 6 s
memory time: 1 s
parallel: 1
inputs: 606 Digits Integer as String
Estimated total run time: 32 s

Benchmarking Apa.add() Dec with input 606 Digits Integer as String...
Benchmarking Apa.add() Int with input 606 Digits Integer as String...
Benchmarking Decimal.add() Dec with input 606 Digits Integer as String...
Benchmarking Decimal.add() Int with input 606 Digits Integer as String...

##### With input 606 Digits Integer as String #####
Name                        ips        average  deviation         median         99th %
Apa.add() Int          924.31 K        1.08 μs ±12622.87%        0.42 μs        2.60 μs
Apa.add() Dec          183.15 K        5.46 μs  ±2928.67%        4.06 μs        9.29 μs
Decimal.add() Int       11.03 K       90.68 μs   ±679.43%       69.09 μs      152.41 μs
Decimal.add() Dec       10.58 K       94.54 μs   ±670.69%       73.36 μs      194.98 μs

Comparison: 
Apa.add() Int          924.31 K
Apa.add() Dec          183.15 K - 5.05x slower +4.38 μs
Decimal.add() Int       11.03 K - 83.81x slower +89.60 μs
Decimal.add() Dec       10.58 K - 87.38x slower +93.46 μs

Memory usage statistics:

Name                 Memory usage
Apa.add() Int           0.0703 KB
Apa.add() Dec           0.0938 KB - 1.33x memory usage +0.0234 KB
Decimal.add() Int         2.25 KB - 32.00x memory usage +2.18 KB
Decimal.add() Dec         1.38 KB - 19.56x memory usage +1.30 KB
```
