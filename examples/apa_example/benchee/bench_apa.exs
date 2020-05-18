inputs = %{
  # "1 Digits Integer" => {6, 9},
  # "6 Digits Integer" => {123_456, 654_321},
  # "15 Digits Integer" => {123_456_789_012_345, 543_210_987_654_321},
  # "22 Digits Integer" => {1_234_567_890_123_456_789_012, 9_876_543_210_987_654_321_098},
  # "23 Digits Integer" =>
  #   {12_345_678_901_234_567_890_123, 98_765_432_109_876_543_210_987},
  # "30 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_891, 987_654_321_098_765_432_109_876_543_211},
  # "42 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012,
  #    987_654_321_012_987_654_321_098_765_432_109_876_543_211},
  # "60 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_891_123_456_789_012_345_678_901_234_567_891,
  #    987_654_321_098_765_432_109_876_543_211_987_654_321_098_765_432_109_876_543_211},
  # "606 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
  #    893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
  # "1 Digits Integer as String" => {"6", "9"},
  # "6 Digits Integer as String" => {"123456", "654321"},
  # "15 Digits Integer as String" => {"123456789012345", "543210987654321"},
  # "22 Digits Integer as String" => {"1234567890123456789012", "9876543210987654321098"},
  # "23 Digits Integer as String" =>
  #   {"12345678901234567890123", "98765432109876543210987"},
  # "30 Digits Integer as String" =>
  #   {"123456789012345678901234567891", "987654321098765432109876543211"},
  # "40 Digits Integer as String" =>
  #   {"1234567890123456789012345678901234567890", "9876543210129876543210987654321098765432"},
  # "42 Digits Integer as String" =>
  #   {"123456789012345678901234567890123456789012", "987654321012987654321098765432109876543298"},
  # "50 Digits Integer as String" =>
  #   {"12345678901234567890123456789012345678901234567890",
  #    "98765432101298765432109876543210987654321098765432"}
  # "60 Digits Integer as String" =>
  #   {"123456789012345678901234567891123456789012345678901234567891",
  #    "987654321098765432109876543211987654321098765432109876543211"},
  # "120 Digits Integer as String" =>
  #   {"123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891",
  #    "987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211"},
  # "240 Digits Integer as String" =>
  #   {"123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891123456789012345678901234567891",
  #    "987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211987654321098765432109876543211"},
  # "606 Digits Integer as String" =>
  #   {"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901",
  #    "893456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789011234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890112345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678999"}

  "6 Digits Integer" => {123_456, 654_321}
  # "42 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012,
  #    987_654_321_012_987_654_321_098_765_432_109_876_543_298},
  # "606 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
  #    893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
}

bench = %{
  # Addition -  Integer values
  "Decimal.div() with precision: 9 via Context Int->float" => fn {l, r} ->
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 9})
    Decimal.div(l, r) |> Decimal.to_string()
  end,
  "Apa.div()    precision: 9             Int->float" => fn {l, r} ->
    Apa.div(l, r, -1, 9)
  end

  # # Addition -  Integer values
  # "Decimal.add() Int" => fn {l, r} ->
  # Decimal.add(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  # |> Decimal.to_string()
  # end,
  # "Apa.add()     Int" => fn {l, r} ->
  #   # Apa.add({l, 0}, {r, 0})
  #   Apa.add(l, r)
  # end

  # # Addition - Decimalpoint values
  # "Decimal.add() Dec" => fn {l, r} ->
  #   Decimal.add(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  #   |> Decimal.to_string()
  # end,
  # "Apa.add() Dec" => fn {l, r} ->
  #   Apa.add({l, -12}, {r, 12})
  # end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 6,
  memory_time: 1,
  print: [fast_warning: false]
)

# bench = %{
#   # Subtraction -  Integer values
#   "Decimal.sub() Int" => fn {l, r} ->
#     Decimal.sub(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
#     |> Decimal.to_string()
#   end,
#   "Apa.sub() Int" => fn {l, r} ->
#     Apa.sub({l, 0}, {r, 0})
#   end,

#   # Subtraction -  Decimalpoint values
#   "Decimal.sub() Dec" => fn {l, r} ->
#     Decimal.sub(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
#     |> Decimal.to_string()
#   end,
#   "Apa.sub() Dec" => fn {l, r} ->
#     Apa.sub({l, -12}, {r, 12})
#   end
# }

# Benchee.run(bench,
#   inputs: inputs,
#   time: 6,
#   warmup: 1,
#   memory_time: 1,
#   print: [fast_warning: false]
#   # save: [path: "apa_benchee_path"]
# )

# bench = %{
#   # Multiplication -  Integer values
#   "Decimal.mult() Int" => fn {l, r} ->
#     Decimal.mult(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
#     |> Decimal.to_string()
#   end,
#   "Apa.mul() Int" => fn {l, r} ->
#     Apa.mul({l, 0}, {r, 0})
#   end,

#   # Multiplication -  Decimalpoint values
#   "Decimal.mult() Dec" => fn {l, r} ->
#     Decimal.mult(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
#     |> Decimal.to_string()
#   end,
#   "Apa.mul() Dec" => fn {l, r} ->
#     Apa.mul({l, -12}, {r, 12})
#   end
# }

# Benchee.run(bench,
#   inputs: inputs,
#   time: 6,
#   warmup: 1,
#   memory_time: 1,
#   print: [fast_warning: false]
#   # save: [path: "apa_benchee_path"]
# )

# bench = %{
#   # Division -  Integer values
#   "Decimal.div() Int" => fn {l, r} ->
#     Decimal.div(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
#     |> Decimal.to_string()
#   end,
#   "Apa.div() Int" => fn {l, r} ->
#     Apa.div({l, 0}, {r, 0})
#   end,

#   # Division -  Decimalpoint values
#   "Decimal.div() Dec" => fn {l, r} ->
#     Decimal.div(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
#     |> Decimal.to_string()
#   end,
#   "Apa.div() Dec" => fn {l, r} ->
#     Apa.div({l, -12}, {r, 12})
#   end
# }

# Benchee.run(bench,
#   inputs: inputs,
#   time: 6,
#   warmup: 1,
#   memory_time: 1,
#   print: [fast_warning: false]
#   # save: [path: "apa_benchee_path"]
# )

#####################################################################################################################################
# usage of precision brings the performance down!!!
# TODO: Optimization -> apa_number.ex - around line 325 !!!!!
#
# ##### With input 42 Digits Integer #####
# Name                                                                   ips        average  deviation         median         99th %
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float      148.53 K        6.73 μs   ±121.98%           6 μs          11 μs
# Decimal.div(100, 3) with precision: 9 via Context Int->float      146.42 K        6.83 μs   ±156.97%           6 μs          20 μs

# Comparison:
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float      148.53 K
# Decimal.div(100, 3) with precision: 9 via Context Int->float      146.42 K - 1.01x slower +0.0969 μs

# Memory usage statistics:

# Name                                                            Memory usage
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float         1.46 KB
# Decimal.div(100, 3) with precision: 9 via Context Int->float         1.53 KB - 1.05x memory usage +0.0703 KB

# **All measurements for memory usage were the same**

# ##### With input 6 Digits Integer #####
# Name                                                                   ips        average  deviation         median         99th %
# Decimal.div(100, 3) with precision: 9 via Context Int->float      404.66 K        2.47 μs   ±946.18%           2 μs           3 μs
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float      285.39 K        3.50 μs   ±433.65%           3 μs           4 μs

# Comparison:
# Decimal.div(100, 3) with precision: 9 via Context Int->float      404.66 K
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float      285.39 K - 1.42x slower +1.03 μs

# Memory usage statistics:

# Name                                                            Memory usage
# Decimal.div(100, 3) with precision: 9 via Context Int->float         1.25 KB
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float         1.46 KB - 1.17x memory usage +0.21 KB

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                                                   ips        average  deviation         median         99th %
# Decimal.div(100, 3) with precision: 9 via Context Int->float       86.13 K       11.61 μs    ±87.95%          11 μs          51 μs
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float       54.22 K       18.44 μs    ±43.61%          17 μs          46 μs

# Comparison:
# Decimal.div(100, 3) with precision: 9 via Context Int->float       86.13 K
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float       54.22 K - 1.59x slower +6.83 μs

# Memory usage statistics:

# Name                                                            Memory usage
# Decimal.div(100, 3) with precision: 9 via Context Int->float         1.25 KB
# Apa.div(100, 3, 9, 7)    precision: 9             Int->float         1.46 KB - 1.17x memory usage +0.21 KB

### Hurraaaaaa
# Speed and memory better for Apa!!!!

# ##### With input 42 Digits Integer #####
# Name                                                             ips        average  deviation         median         99th %
# Apa.div()    precision: 9             Int->float            492.08 K        2.03 μs  ±1017.52%        1.98 μs        2.98 μs
# Decimal.div() with precision: 9 via Context Int->float      152.63 K        6.55 μs   ±149.70%        5.98 μs       11.98 μs

# Comparison:
# Apa.div()    precision: 9             Int->float            492.08 K
# Decimal.div() with precision: 9 via Context Int->float      152.63 K - 3.22x slower +4.52 μs

# Memory usage statistics:

# Name                                                      Memory usage
# Apa.div()    precision: 9             Int->float               0.51 KB
# Decimal.div() with precision: 9 via Context Int->float         1.53 KB - 3.02x memory usage +1.02 KB

# **All measurements for memory usage were the same**

# ##### With input 6 Digits Integer #####
# Name                                                             ips        average  deviation         median         99th %
# Apa.div()    precision: 9             Int->float              1.02 M        0.98 μs  ±2862.09%        0.98 μs        0.98 μs
# Decimal.div() with precision: 9 via Context Int->float        0.39 M        2.59 μs   ±959.84%        1.98 μs        2.98 μs

# Comparison:
# Apa.div()    precision: 9             Int->float              1.02 M
# Decimal.div() with precision: 9 via Context Int->float        0.39 M - 2.63x slower +1.61 μs

# Memory usage statistics:

# Name                                                      Memory usage
# Apa.div()    precision: 9             Int->float               0.51 KB
# Decimal.div() with precision: 9 via Context Int->float         1.25 KB - 2.46x memory usage +0.74 KB

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                                             ips        average  deviation         median         99th %
# Apa.div()    precision: 9             Int->float            207.13 K        4.83 μs   ±198.57%        3.98 μs        9.98 μs
# Decimal.div() with precision: 9 via Context Int->float       80.82 K       12.37 μs    ±63.87%       10.98 μs       56.98 μs

# Comparison:
# Apa.div()    precision: 9             Int->float            207.13 K
# Decimal.div() with precision: 9 via Context Int->float       80.82 K - 2.56x slower +7.55 μs

# Memory usage statistics:

# Name                                                      Memory usage
# Apa.div()    precision: 9             Int->float               0.51 KB
# Decimal.div() with precision: 9 via Context Int->float         1.25 KB - 2.46x memory usage +0.74 KB

#########
# Benchmarking Apa.div()    precision: 9             Int->float with input 6 Digits Integer...
# Benchmarking Decimal.div() with precision: 9 via Context Int->float with input 6 Digits Integer...

# ##### With input 6 Digits Integer #####
# Name                                                             ips        average  deviation         median         99th %
# Apa.div()    precision: 9             Int->float            904.83 K        1.11 μs  ±2391.15%        0.98 μs        1.98 μs
# Decimal.div() with precision: 9 via Context Int->float      404.79 K        2.47 μs   ±957.15%        1.98 μs        2.98 μs

# Comparison:
# Apa.div()    precision: 9             Int->float            904.83 K
# Decimal.div() with precision: 9 via Context Int->float      404.79 K - 2.24x slower +1.37 μs

# Memory usage statistics:

# Name                                                      Memory usage
# Apa.div()    precision: 9             Int->float               0.51 KB
# Decimal.div() with precision: 9 via Context Int->float         1.25 KB - 2.46x memory usage +0.74 KB
