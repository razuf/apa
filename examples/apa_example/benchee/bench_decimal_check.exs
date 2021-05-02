inputs = %{
  # "606 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
  #    893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
  "606 Digits Integer, 2 digits exp" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     -21}
}

bench = %{
  "Decimal  struct" => fn {l, r} ->
    # %Decimal{sign: 1, coef: l, exp: r} |> Decimal.to_string()
    %Decimal{sign: 1, coef: l, exp: r}
  end,
  "Apa       tuple" => fn {l, r} ->
    # {l, r} |> Apa.to_string()
    # test for length in tuple
    {l, r, 606}
  end
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

# ############# decimal check: Struct - Tuple
# ##### With input 606 Digits Integer, 2 digits exp #####
# Name                            ips        average  deviation         median         99th %
# Apa.number()    tuple        7.36 M      135.89 ns  ±5073.28%           0 ns        1000 ns
# Decimal.add()  struct        5.00 M      200.15 ns ±13244.81%           0 ns        1000 ns

# Comparison:
# Apa.number()    tuple        7.36 M
# Decimal.add()  struct        5.00 M - 1.47x slower +64.26 ns

# Memory usage statistics:

# Name                     Memory usage
# Apa.number()    tuple             0 B
# Decimal.add()  struct            96 B - ∞ x memory usage +96 B

#########################################################
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