inputs = %{
  # "606 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
  #    893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
  "30 Digits Float" => {123.456789012345678901234567890, 893_456_789_012_345_678_901_234_567.999}
}

bench = %{
  # Float check
  "Decimal.div()  Float" => fn {l, r} ->
    Decimal.div(Decimal.from_float(l), Decimal.from_float(r)) |> Decimal.to_string()
  end,
  "Apa.div()      Float" => fn {l, r} ->
    Apa.div(l, r)
  end

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

  # may be a bit unfair ... but why ??? its looking the same

  # "Decimal.add()              Int" => fn {l, r} ->
  #   Decimal.add(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  # end,
  # "ApaAdd.bc_add_apa_number() Int" => fn {l, r} ->
  #   ApaAdd.bc_add_apa_number({l, 0}, {r, 0})
  # end,
  # "Decimal.add()              Dec" => fn {l, r} ->
  #   Decimal.add(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  # end,
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

###################################################################
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
