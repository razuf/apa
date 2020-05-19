inputs = %{
  "30 Digits Integer" =>
    {123_456_789_012_345_678_901_234_567_890, 987_654_321_098_765_432_109_876_543_210},
  "606 Digits Integer" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
}

bench = %{
  # To String Convert with standard precision and scale
  "Decimal.to_string() Int" => fn {l, r} ->
    Decimal.to_string(%Decimal{sign: 1, coef: l, exp: 0})
  end,
  "Apa.to_string()     Int" => fn {l, r} ->
    Apa.to_string({l, 0})
  end,
  "Decimal.to_string() Dec" => fn {l, r} ->
    Decimal.to_string(%Decimal{sign: 1, coef: l, exp: -3})
  end,
  "Apa.to_string()     Dec" => fn {l, r} ->
    Apa.to_string({l, -3})
  end

  # # To String Convert with special value "9" for precision/scale
  # "Decimal.to_string() Int/precison 9:" => fn {l, r} ->
  #   # Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 9})
  #   Decimal.to_string(%Decimal{sign: 1, coef: l, exp: 0})
  # end,
  # "Apa.to_string()     Int/precison 9:" => fn {l, r} ->
  #   Apa.to_string({l, 0}, -1, 9)
  # end,
  # "Decimal.to_string() Dec/precison 9:" => fn {l, r} ->
  #   Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 9})
  #   Decimal.to_string(%Decimal{sign: 1, coef: l, exp: -3})
  # end,
  # "Apa.to_string()     Dec/precison 9:" => fn {l, r} ->
  #   Apa.to_string({l, -3}, -1, 9)
  # end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 6,
  memory_time: 1,
  print: [fast_warning: false]
)

# nearly the same speed and memory

# ##### With input 30 Digits Integer #####
# Name                              ips        average  deviation         median         99th %
# Apa.to_string()     Int        1.76 M        0.57 μs  ±2236.05%           1 μs           1 μs
# Decimal.to_string() Int        1.20 M        0.83 μs  ±3564.41%           1 μs           1 μs
# Apa.to_string()     Dec        0.83 M        1.21 μs  ±2668.47%           1 μs           2 μs
# Decimal.to_string() Dec        0.79 M        1.26 μs  ±2037.83%           1 μs           2 μs

# Comparison:
# Apa.to_string()     Int        1.76 M
# Decimal.to_string() Int        1.20 M - 1.46x slower +0.26 μs
# Apa.to_string()     Dec        0.83 M - 2.13x slower +0.64 μs
# Decimal.to_string() Dec        0.79 M - 2.21x slower +0.69 μs

# Memory usage statistics:

# Name                       Memory usage
# Apa.to_string()     Int       0.0703 KB
# Decimal.to_string() Int         0.61 KB - 8.67x memory usage +0.54 KB
# Apa.to_string()     Dec            1 KB - 14.22x memory usage +0.93 KB
# Decimal.to_string() Dec         1.05 KB - 14.89x memory usage +0.98 KB

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                              ips        average  deviation         median         99th %
# Apa.to_string()     Int       51.78 K       19.31 μs    ±34.03%          18 μs          43 μs
# Decimal.to_string() Int       45.92 K       21.78 μs    ±31.66%          21 μs          41 μs
# Decimal.to_string() Dec       33.90 K       29.49 μs    ±22.95%          28 μs          55 μs
# Apa.to_string()     Dec       33.71 K       29.66 μs    ±26.67%          28 μs          55 μs

# Comparison:
# Apa.to_string()     Int       51.78 K
# Decimal.to_string() Int       45.92 K - 1.13x slower +2.46 μs
# Decimal.to_string() Dec       33.90 K - 1.53x slower +10.18 μs
# Apa.to_string()     Dec       33.71 K - 1.54x slower +10.35 μs

# Memory usage statistics:

# Name                       Memory usage
# Apa.to_string()     Int       0.0703 KB
# Decimal.to_string() Int        0.141 KB - 2.00x memory usage +0.0703 KB
# Decimal.to_string() Dec         9.58 KB - 136.22x memory usage +9.51 KB
# Apa.to_string()     Dec         9.53 KB - 135.56x memory usage +9.46 KB

# ##### With input 30 Digits Integer #####
# Name                                          ips        average  deviation         median         99th %
# Decimal.to_string() Dec/precison 9:      748.19 K        1.34 μs  ±1840.05%           1 μs           2 μs
# Apa.to_string()     Dec/precison 9:      734.60 K        1.36 μs  ±1844.56%           1 μs           2 μs

# Comparison:
# Decimal.to_string() Dec/precison 9:      748.19 K
# Apa.to_string()     Dec/precison 9:      734.60 K - 1.02x slower +0.0247 μs

# Memory usage statistics:

# Name                                   Memory usage
# Decimal.to_string() Dec/precison 9:         1.05 KB
# Apa.to_string()     Dec/precison 9:         1.10 KB - 1.05x memory usage +0.0547 KB

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                          ips        average  deviation         median         99th %
# Apa.to_string()     Dec/precison 9:       34.27 K       29.18 μs    ±17.61%          28 μs          53 μs
# Decimal.to_string() Dec/precison 9:       34.15 K       29.29 μs    ±26.68%          28 μs          54 μs

# Comparison:
# Apa.to_string()     Dec/precison 9:       34.27 K
# Decimal.to_string() Dec/precison 9:       34.15 K - 1.00x slower +0.107 μs

# Memory usage statistics:

# Name                                   Memory usage
# Apa.to_string()     Dec/precison 9:         9.53 KB
# Decimal.to_string() Dec/precison 9:         9.58 KB - 1.00x memory usage +0.0469 KB
