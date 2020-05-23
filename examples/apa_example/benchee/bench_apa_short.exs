inputs = %{
  # "1 Digits Integer" => {6, 9},
  "6 Digits Integer" => {123_456, 654_321},
  # "15 Digits Integer" => {123_456_789_012_345, 543_210_987_654_321},
  "30 Digits Integer" =>
    {123_456_789_012_345_678_901_234_567_890, 893_456_789_012_345_678_901_234_567_999},
  "606 Digits Integer" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
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

  "Decimal.add()    Int" => fn {l, r} ->
    Decimal.add(l, r) |> Decimal.to_string()
  end,
  "Apa.add()        Int" => fn {l, r} ->
    Apa.add(l, r)
  end

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
  # end,
  # "ApaDiv.bc_div_apa_number() Int" => fn {l, r} ->
  #   ApaDiv.bc_div_apa_number({l, 0}, {r, 0})
  # end,
  # "Decimal.div()              Dec" => fn {l, r} ->
  #   Decimal.div(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  # end,
  # "ApaDiv.bc_div_apa_number() Dec" => fn {l, r} ->
  #   ApaDiv.bc_div_apa_number({l, -12}, {r, 12})
  # end

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
  time: 6,
  warmup: 6,
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
