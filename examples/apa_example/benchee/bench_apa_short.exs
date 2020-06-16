inputs = %{
  # "a 1 Digits Integer" => {6, 9},
  "b 6 Digits Input" => {123_456, 654_321},
  # "c 15 Digits Integer" => {123_456_789_012_345, 543_210_987_654_321},
  "d 30 Digits Input" =>
    {123_456_789_012_345_678_901_234_567_890, 893_456_789_012_345_678_901_234_567_999},
  # "e 120 Digits Integer as String" =>
  #   {123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891,
  #    987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211},
  "f 240 Digits Integer as String" =>
    {123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891,
     987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211},
  "g 606 Digits Input" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}

  # special div check
  # "a 6 Digits Input special" => {1, 32_111_111_111_111_111_111_111_111_111}
  # "30 Digits Float" => {123.456789012345678901234567890, 893_456_789_012_345_678_901_234_567.999}
}

bench = %{
  # # Float check
  # "Decimal.div()  Float" => fn {l, r} ->
  #   Decimal.div(Decimal.from_float(l), Decimal.from_float(r)) |> Decimal.to_string()
  # end,
  # "Apa.div()      Float" => fn {l, r} ->
  #   Apa.div(l, r)
  # end

  # "Decimal.add()  Float" => fn {l, r} ->
  #   Decimal.add(Decimal.from_float(l), Decimal.from_float(r)) |> Decimal.to_string()
  # end,
  # "Apa.add()      Float" => fn {l, r} ->
  #   Apa.add(l, r)
  # end

  # Int check

  # "Decimal.add()    Int" => fn {l, r} ->
  #   Decimal.add(l, r) |> Decimal.to_string()
  # end,
  # "Apa.add()        Int" => fn {l, r} ->
  #   Apa.add(l, r)
  # end

  # may be a bit unfair ... but why ??? its looking comparable: both struct or tuple input and output
  # it must be the last conversion ??? impl inspect and then to_string

  # "Decimal.mult()              Int" => fn {l, r} ->
  #   Decimal.mult(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  # end,
  # "ApaMul.bc_mul_apa_number()  Int" => fn {l, r} ->
  #   ApaMul.bc_mul_apa_number({l, 0}, {r, 0})
  # end,
  # "Decimal.mult()              Dec" => fn {l, r} ->
  #   Decimal.mult(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  # end,
  # "ApaMul.bc_mul_apa_number()  Dec" => fn {l, r} ->
  #   ApaMul.bc_mul_apa_number({l, -12}, {r, 12})
  # end

  # "Decimal.div()              Int" => fn {l, r} ->
  #   Decimal.div(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  #   # Decimal.div(
  #   #   "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901",
  #   #   "893456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678999"
  #   # )
  #   # |> Decimal.to_string()
  # end,
  # "ApaDiv.bc_div_apa_number() Int" => fn {l, r} ->
  #   ApaDiv.bc_div_apa_number({l, 0}, {r, 0})
  #   # Apa.div(
  #   #   "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901",
  #   #   "893456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678999"
  #   # )
  # end,
  "Decimal.div()              Dec" => fn {l, r} ->
    Decimal.div(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  end,
  "ApaDiv.bc_div_apa_number() Dec" => fn {l, r} ->
    ApaDiv.bc_div_apa_number({l, -12}, {r, 12})
  end

  # "Decimal.add()              Int" => fn {l, r} ->
  #   Decimal.add(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  # end,
  # "ApaAdd.bc_add_apa_number() Int" => fn {l, r} ->
  #   ApaAdd.bc_add_apa_number({l, 0}, {r, 0})
  # end,
  # # "Decimal.add()              Dec" => fn {l, r} ->
  # #   Decimal.add(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  # # end,
  # "ApaAdd.bc_add_apa_number() Dec" => fn {l, r} ->
  #   ApaAdd.bc_add_apa_number({l, -12}, {r, 12})
  # end
}

Benchee.run(bench,
  inputs: inputs,
  time: 3,
  warmup: 3,
  memory_time: 1,
  print: [fast_warning: false]
)

#############################################
# Multiplication
#############################################
# ##### With input 30 Digits Float #####
# Name                                      ips        average  deviation         median         99th %
# ApaMul.bc_mul_apa_number()  Dec        4.00 M        0.25 μs ±17183.70%           0 μs        0.98 μs
# ApaMul.bc_mul_apa_number()  Int        3.78 M        0.26 μs ±15953.43%           0 μs        0.98 μs
# Decimal.mult()              Int        0.42 M        2.39 μs   ±857.43%        1.98 μs        2.98 μs
# Decimal.mult()              Dec        0.42 M        2.41 μs   ±863.29%        1.98 μs        2.98 μs

# Comparison:
# ApaMul.bc_mul_apa_number()  Dec        4.00 M
# ApaMul.bc_mul_apa_number()  Int        3.78 M - 1.06x slower +0.0144 μs
# Decimal.mult()              Int        0.42 M - 9.55x slower +2.14 μs
# Decimal.mult()              Dec        0.42 M - 9.62x slower +2.16 μs

# Memory usage statistics:

# Name                               Memory usage
# ApaMul.bc_mul_apa_number()  Dec       0.0703 KB
# ApaMul.bc_mul_apa_number()  Int       0.0703 KB - 1.00x memory usage +0 KB
# Decimal.mult()              Int         3.16 KB - 45.00x memory usage +3.09 KB
# Decimal.mult()              Dec         3.16 KB - 45.00x memory usage +3.09 KB

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                      ips        average  deviation         median         99th %
# ApaMul.bc_mul_apa_number()  Dec      225.62 K        4.43 μs   ±208.17%        3.98 μs        4.98 μs
# ApaMul.bc_mul_apa_number()  Int      223.81 K        4.47 μs   ±220.94%        3.98 μs        4.98 μs
# Decimal.mult()              Dec       12.37 K       80.84 μs    ±20.57%       76.98 μs      141.98 μs
# Decimal.mult()              Int       12.33 K       81.12 μs    ±20.40%       76.98 μs      142.98 μs

# Comparison:
# ApaMul.bc_mul_apa_number()  Dec      225.62 K
# ApaMul.bc_mul_apa_number()  Int      223.81 K - 1.01x slower +0.0359 μs
# Decimal.mult()              Dec       12.37 K - 18.24x slower +76.41 μs
# Decimal.mult()              Int       12.33 K - 18.30x slower +76.69 μs

# Memory usage statistics:

# Name                               Memory usage
# ApaMul.bc_mul_apa_number()  Dec            72 B
# ApaMul.bc_mul_apa_number()  Int            72 B - 1.00x memory usage +0 B
# Decimal.mult()              Dec           936 B - 13.00x memory usage +864 B
# Decimal.mult()              Int           936 B - 13.00x memory usage +864 B

##############################################
# ##### With input 30 Digits Float #####
# Name                           ips        average  deviation         median         99th %
# Apa.div()      Float       81.87 K       12.22 μs    ±77.28%          12 μs          26 μs
# Decimal.div()  Float       52.17 K       19.17 μs    ±41.62%          18 μs          44 μs

# Comparison:
# Apa.div()      Float       81.87 K
# Decimal.div()  Float       52.17 K - 1.57x slower +6.95 μs

# Memory usage statistics:

# Name                    Memory usage
# Apa.div()      Float         4.23 KB
# Decimal.div()  Float         9.45 KB - 2.23x memory usage +5.21 KB

##############################################
# Decimal float test
# Apa is more preicise and faster and half the memory
##############################################
# iex(1)> l = 123.456789012345678901234567890
# 123.45678901234568
# iex(2)> r = 1_234_567_890_123_456_789_012_345_67.999
# 1.2345678901234568e26
# iex(3)>     Decimal.add(Decimal.from_float(l), Decimal.from_float(r)) |> Decimal.to_string()
# "123456789012345680000000123.5"
# iex(4)>     Apa.add(l, r)
# "123456789012345680000000123.45678901234568"
# ##### With input 30 Digits Float #####
# Name                           ips        average  deviation         median         99th %
# Apa.add()      Float       92.66 K       10.79 μs    ±77.05%       10.98 μs       17.98 μs
# Decimal.add()  Float       69.29 K       14.43 μs    ±24.62%       13.98 μs       20.98 μs

# Comparison:
# Apa.add()      Float       92.66 K
# Decimal.add()  Float       69.29 K - 1.34x slower +3.64 μs

# Memory usage statistics:

# Name                    Memory usage
# Apa.add()      Float         4.04 KB
# Decimal.add()  Float         9.08 KB - 2.25x memory usage +5.04 KB

# Decimal is using %Decimal struct for input/output - Apa without conversion directly integer operations and tuple input/output

# ##### With input 606 Digits Integer #####
# Name                                     ips        average  deviation         median         99th %
# ApaAdd.bc_add_apa_number() Int     3439.77 K        0.29 μs  ±8604.04%           0 μs        0.98 μs
# ApaAdd.bc_add_apa_number() Dec      626.99 K        1.59 μs   ±671.96%        1.98 μs        1.98 μs
# Decimal.add()              Int       45.80 K       21.83 μs    ±39.58%       20.98 μs       49.98 μs
# Decimal.add()              Dec       41.35 K       24.18 μs    ±58.63%       22.98 μs       51.98 μs

# Comparison:
# ApaAdd.bc_add_apa_number() Int     3439.77 K
# ApaAdd.bc_add_apa_number() Dec      626.99 K - 5.49x slower +1.30 μs
# Decimal.add()              Int       45.80 K - 75.10x slower +21.54 μs
# Decimal.add()              Dec       41.35 K - 83.18x slower +23.89 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaAdd.bc_add_apa_number() Int       0.0703 KB
# ApaAdd.bc_add_apa_number() Dec       0.0938 KB - 1.33x memory usage +0.0234 KB
# Decimal.add()              Int         2.25 KB - 32.00x memory usage +2.18 KB
# Decimal.add()              Dec         1.38 KB - 19.56x memory usage +1.30 KB

###############################################################################
# Integer
###############################################################################

# ##### With input 30 Digits Integer #####
# Name                           ips        average  deviation         median         99th %
# Apa.add()        Int        1.35 M        0.74 μs  ±4286.69%           1 μs           1 μs
# Decimal.add()    Int        0.33 M        3.05 μs   ±692.90%           3 μs           4 μs

# Comparison:
# Apa.add()        Int        1.35 M
# Decimal.add()    Int        0.33 M - 4.12x slower +2.31 μs

# Memory usage statistics:

# Name                    Memory usage
# Apa.add()        Int        0.117 KB
# Decimal.add()    Int         4.27 KB - 36.47x memory usage +4.16 KB

# **All measurements for memory usage were the same**

# ##### With input 6 Digits Integer #####
# Name                           ips        average  deviation         median         99th %
# Apa.add()        Int        2.78 M      359.14 ns  ±6112.23%           0 ns        1000 ns
# Decimal.add()    Int        1.05 M      956.18 ns  ±2050.46%        1000 ns        1000 ns

# Comparison:
# Apa.add()        Int        2.78 M
# Decimal.add()    Int        1.05 M - 2.66x slower +597.04 ns

# Memory usage statistics:

# Name                    Memory usage
# Apa.add()        Int            96 B
# Decimal.add()    Int           592 B - 6.17x memory usage +496 B

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                           ips        average  deviation         median         99th %
# Apa.add()        Int       54.03 K       18.51 μs    ±40.41%          18 μs          34 μs
# Decimal.add()    Int       45.58 K       21.94 μs    ±24.30%          21 μs          30 μs

# Comparison:
# Apa.add()        Int       54.03 K
# Decimal.add()    Int       45.58 K - 1.19x slower +3.43 μs

# Memory usage statistics:

# Name                    Memory usage
# Apa.add()        Int        0.117 KB
# Decimal.add()    Int         3.74 KB - 31.93x memory usage +3.63 KB

################################################# newer test after first opti 16.6.2020

# mix run benchee/bench_apa_short.exs
# Operating System: macOS
# Elixir 1.10.3
# Erlang 23.0.2

# warmup: 3 s
# time: 3 s
# memory time: 1 s
# parallel: 1

# ##### With input a 1 Digits Integer #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec      435.82 K        2.29 μs   ±360.17%        1.98 μs        2.98 μs
# Decimal.div()              Dec      163.05 K        6.13 μs    ±56.14%        5.98 μs       11.98 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec      435.82 K
# Decimal.div()              Dec      163.05 K - 2.67x slower +3.84 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec         0.76 KB
# Decimal.div()              Dec         2.72 KB - 3.59x memory usage +1.96 KB

# **All measurements for memory usage were the same**

# ##### With input b 6 Digits Input #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec      383.71 K        2.61 μs    ±55.74%        2.98 μs        2.98 μs
# Decimal.div()              Dec      176.35 K        5.67 μs    ±77.02%        5.98 μs        8.98 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec      383.71 K
# Decimal.div()              Dec      176.35 K - 2.18x slower +3.06 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec         0.76 KB
# Decimal.div()              Dec         2.72 KB - 3.59x memory usage +1.96 KB

# **All measurements for memory usage were the same**

# ##### With input c 15 Digits Integer #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec      280.82 K        3.56 μs    ±45.44%        2.98 μs        4.98 μs
# Decimal.div()              Dec      188.76 K        5.30 μs    ±73.90%        4.98 μs        9.98 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec      280.82 K
# Decimal.div()              Dec      188.76 K - 1.49x slower +1.74 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec         0.76 KB
# Decimal.div()              Dec         1.84 KB - 2.43x memory usage +1.09 KB

# **All measurements for memory usage were the same**

# ##### With input d 30 Digits Input #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec      211.92 K        4.72 μs    ±45.19%        4.98 μs        6.98 μs
# Decimal.div()              Dec       82.00 K       12.20 μs    ±35.78%       11.98 μs       32.98 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec      211.92 K
# Decimal.div()              Dec       82.00 K - 2.58x slower +7.48 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec         0.76 KB
# Decimal.div()              Dec         1.84 KB - 2.43x memory usage +1.09 KB

# **All measurements for memory usage were the same**

# ##### With input e 606 Digits Input #####
# Name                                     ips        average  deviation         median         99th %
# Decimal.div()              Dec       39.52 K       25.31 μs    ±30.20%       23.98 μs       66.98 μs
# ApaDiv.bc_div_apa_number() Dec       18.32 K       54.57 μs    ±15.00%       52.98 μs       80.98 μs

# Comparison:
# Decimal.div()              Dec       39.52 K
# ApaDiv.bc_div_apa_number() Dec       18.32 K - 2.16x slower +29.27 μs

# Memory usage statistics:

# Name                              Memory usage
# Decimal.div()              Dec         1.84 KB
# ApaDiv.bc_div_apa_number() Dec         0.82 KB - 0.44x memory usage -1.02344 KB

# **All measurements for memory usage were the same**

################################################# newer test after second opti 16.6.2020

# mix run benchee/bench_apa_short.exs
# Operating System: macOS
# Elixir 1.10.3
# Erlang 23.0.2

# warmup: 3 s
# time: 3 s
# memory time: 1 s
# parallel: 1

# ##### With input a 1 Digits Integer #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec        1.62 M        0.62 μs  ±5280.09%           1 μs           1 μs
# ApaDiv.bc_div_apa_number() Int        1.60 M        0.63 μs  ±5264.54%           1 μs           1 μs
# Decimal.div()              Int       0.167 M        6.00 μs    ±59.64%           6 μs           9 μs
# Decimal.div()              Dec       0.161 M        6.20 μs    ±74.22%           6 μs          13 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec        1.62 M
# ApaDiv.bc_div_apa_number() Int        1.60 M - 1.01x slower +0.00838 μs
# Decimal.div()              Int       0.167 M - 9.72x slower +5.38 μs
# Decimal.div()              Dec       0.161 M - 10.05x slower +5.59 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec        0.125 KB
# ApaDiv.bc_div_apa_number() Int        0.125 KB - 1.00x memory usage +0 KB
# Decimal.div()              Int         2.72 KB - 21.75x memory usage +2.59 KB
# Decimal.div()              Dec         2.72 KB - 21.75x memory usage +2.59 KB

# **All measurements for memory usage were the same**

# ##### With input b 6 Digits Input #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Int        1.62 M        0.62 μs  ±4652.02%           1 μs           1 μs
# ApaDiv.bc_div_apa_number() Dec        1.54 M        0.65 μs  ±3825.49%           1 μs           1 μs
# Decimal.div()              Int       0.169 M        5.93 μs    ±69.79%           6 μs          13 μs
# Decimal.div()              Dec       0.166 M        6.01 μs    ±75.29%           6 μs          13 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Int        1.62 M
# ApaDiv.bc_div_apa_number() Dec        1.54 M - 1.05x slower +0.0324 μs
# Decimal.div()              Int       0.169 M - 9.61x slower +5.31 μs
# Decimal.div()              Dec       0.166 M - 9.75x slower +5.40 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Int        0.125 KB
# ApaDiv.bc_div_apa_number() Dec        0.125 KB - 1.00x memory usage +0 KB
# Decimal.div()              Int         2.72 KB - 21.75x memory usage +2.59 KB
# Decimal.div()              Dec         2.72 KB - 21.75x memory usage +2.59 KB

# **All measurements for memory usage were the same**

# ##### With input c 15 Digits Integer #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Int        1.61 M        0.62 μs  ±3274.64%           1 μs           1 μs
# ApaDiv.bc_div_apa_number() Dec        1.59 M        0.63 μs  ±4923.06%           1 μs           1 μs
# Decimal.div()              Int       0.188 M        5.33 μs   ±196.13%           5 μs          10 μs
# Decimal.div()              Dec       0.186 M        5.38 μs   ±189.88%           5 μs          10 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Int        1.61 M
# ApaDiv.bc_div_apa_number() Dec        1.59 M - 1.01x slower +0.00875 μs
# Decimal.div()              Int       0.188 M - 8.60x slower +4.71 μs
# Decimal.div()              Dec       0.186 M - 8.68x slower +4.76 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Int        0.125 KB
# ApaDiv.bc_div_apa_number() Dec        0.125 KB - 1.00x memory usage +0 KB
# Decimal.div()              Int         1.84 KB - 14.75x memory usage +1.72 KB
# Decimal.div()              Dec         1.84 KB - 14.75x memory usage +1.72 KB

# **All measurements for memory usage were the same**

# ##### With input d 30 Digits Input #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec        1.27 M        0.79 μs  ±3767.67%           1 μs           1 μs
# ApaDiv.bc_div_apa_number() Int        1.26 M        0.79 μs  ±3676.66%           1 μs           1 μs
# Decimal.div()              Int      0.0845 M       11.84 μs    ±35.35%          11 μs          31 μs
# Decimal.div()              Dec      0.0805 M       12.42 μs    ±63.12%          12 μs          26 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec        1.27 M
# ApaDiv.bc_div_apa_number() Int        1.26 M - 1.01x slower +0.00478 μs
# Decimal.div()              Int      0.0845 M - 14.99x slower +11.05 μs
# Decimal.div()              Dec      0.0805 M - 15.73x slower +11.63 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec        0.125 KB
# ApaDiv.bc_div_apa_number() Int        0.125 KB - 1.00x memory usage +0 KB
# Decimal.div()              Int         1.84 KB - 14.75x memory usage +1.72 KB
# Decimal.div()              Dec         1.84 KB - 14.75x memory usage +1.72 KB

# **All measurements for memory usage were the same**

# ##### With input e 120 Digits Integer as String #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Dec      979.68 K        1.02 μs  ±2046.40%           1 μs           2 μs
# ApaDiv.bc_div_apa_number() Int      979.34 K        1.02 μs  ±1835.29%           1 μs           2 μs
# Decimal.div()              Int       73.78 K       13.55 μs    ±36.38%          13 μs          32 μs
# Decimal.div()              Dec       73.18 K       13.67 μs    ±36.55%          13 μs          32 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Dec      979.68 K
# ApaDiv.bc_div_apa_number() Int      979.34 K - 1.00x slower +0.00035 μs
# Decimal.div()              Int       73.78 K - 13.28x slower +12.53 μs
# Decimal.div()              Dec       73.18 K - 13.39x slower +12.64 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Dec        0.125 KB
# ApaDiv.bc_div_apa_number() Int        0.125 KB - 1.00x memory usage +0 KB
# Decimal.div()              Int         2.72 KB - 21.75x memory usage +2.59 KB
# Decimal.div()              Dec         2.72 KB - 21.75x memory usage +2.59 KB

# **All measurements for memory usage were the same**

# ##### With input f 240 Digits Integer as String #####
# Name                                     ips        average  deviation         median         99th %
# ApaDiv.bc_div_apa_number() Int      777.74 K        1.29 μs   ±915.67%           1 μs           2 μs
# ApaDiv.bc_div_apa_number() Dec      777.06 K        1.29 μs  ±1032.09%           1 μs           2 μs
# Decimal.div()              Dec       61.45 K       16.27 μs    ±26.59%          15 μs          35 μs
# Decimal.div()              Int       61.06 K       16.38 μs    ±36.41%          15 μs          51 μs

# Comparison:
# ApaDiv.bc_div_apa_number() Int      777.74 K
# ApaDiv.bc_div_apa_number() Dec      777.06 K - 1.00x slower +0.00112 μs
# Decimal.div()              Dec       61.45 K - 12.66x slower +14.99 μs
# Decimal.div()              Int       61.06 K - 12.74x slower +15.09 μs

# Memory usage statistics:

# Name                              Memory usage
# ApaDiv.bc_div_apa_number() Int        0.125 KB
# ApaDiv.bc_div_apa_number() Dec        0.125 KB - 1.00x memory usage +0 KB
# Decimal.div()              Dec         2.72 KB - 21.75x memory usage +2.59 KB
# Decimal.div()              Int         2.72 KB - 21.75x memory usage +2.59 KB

# **All measurements for memory usage were the same**

# ##### With input g 606 Digits Input #####
# Name                                     ips        average  deviation         median         99th %
# Decimal.div()              Dec       41.40 K       24.15 μs    ±26.20%          23 μs          53 μs
# Decimal.div()              Int       40.61 K       24.62 μs    ±30.31%          23 μs          65 μs
# ApaDiv.bc_div_apa_number() Dec       24.49 K       40.84 μs    ±25.90%          39 μs          98 μs
# ApaDiv.bc_div_apa_number() Int       24.38 K       41.02 μs    ±22.32%          39 μs          92 μs

# Comparison:
# Decimal.div()              Dec       41.40 K
# Decimal.div()              Int       40.61 K - 1.02x slower +0.47 μs
# ApaDiv.bc_div_apa_number() Dec       24.49 K - 1.69x slower +16.68 μs
# ApaDiv.bc_div_apa_number() Int       24.38 K - 1.70x slower +16.86 μs

# Memory usage statistics:

# Name                              Memory usage
# Decimal.div()              Dec         1.84 KB
# Decimal.div()              Int         1.84 KB - 1.00x memory usage +0 KB
# ApaDiv.bc_div_apa_number() Dec        0.188 KB - 0.10x memory usage -1.65625 KB
# ApaDiv.bc_div_apa_number() Int        0.188 KB - 0.10x memory usage -1.65625 KB
