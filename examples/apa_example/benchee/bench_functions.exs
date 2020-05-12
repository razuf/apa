inputs = %{
  "3 Zeros" => {3, 3},
  "30 Zeros" => {30, 30},
  "300 Zeros" => {300, 300},
  "1 Mio Zeros" => {1_000_000, 1_000_000}
  # "1 Digits Integer as String" => {"3", ['3']},
  # "30 Digits Integer as String" =>
  #   {"123456789012345678901234567890", ['123456789012345678901234567890']}
  # "606 Digits Integer as String" =>
  #   {"123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901"}
}

bench = %{
  # "Elixir Kernel.byte_size" => fn {l, r} -> Kernel.byte_size(l) end,
  # "Elixir String.length" => fn {l, r} -> String.length(l) end,
  # "Elixir Kernel.length" => fn {l, r} -> Kernel.length(r) end

  # "Kernel.length()" => fn {l, r} ->
  #   Kernel.length(r)
  # end,
  # "String.length()" => fn {l, r} ->
  #   String.length(l)
  # end

  # maybe better :lists.duplicate(scale, ?0) - no its much slower!!!
  # String.duplicate("0", scale) - this is much faster!!! and less memory usage
  ":lists.duplicate()" => fn {l, r} ->
    :lists.duplicate(l, ?0)
  end,
  "String.duplicate()" => fn {l, r} ->
    String.duplicate("0", l)
  end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 1,
  memory_time: 1,
  print: [fast_warning: false]
)

# ##### With input 1 Digits Integer as String #####
# Name                              ips        average  deviation         median         99th %
# Elixir Kernel.byte_size        6.52 M      153.47 ns  ±4748.02%           0 ns         980 ns
# Elixir Kernel.length           6.40 M      156.32 ns  ±4636.91%           0 ns         980 ns
# Elixir String.length           3.94 M      254.02 ns  ±4900.69%           0 ns         980 ns

# Comparison:
# Elixir Kernel.byte_size        6.52 M
# Elixir Kernel.length           6.40 M - 1.02x slower +2.85 ns
# Elixir String.length           3.94 M - 1.66x slower +100.55 ns

# Memory usage statistics:

# Name                       Memory usage
# Elixir Kernel.byte_size             0 B
# Elixir Kernel.length                0 B - 1.00x memory usage +0 B
# Elixir String.length              144 B - ∞ x memory usage +144 B

# ##### With input 30 Digits Integer as String #####
# Name                              ips        average  deviation         median         99th %
# Elixir Kernel.byte_size        6.51 M      153.51 ns  ±4593.39%           0 ns         980 ns
# Elixir Kernel.length           6.18 M      161.86 ns  ±4770.45%           0 ns         980 ns
# Elixir String.length           0.57 M     1741.92 ns  ±1258.20%        1980 ns        2980 ns

# Comparison:
# Elixir Kernel.byte_size        6.51 M
# Elixir Kernel.length           6.18 M - 1.05x slower +8.36 ns
# Elixir String.length           0.57 M - 11.35x slower +1588.42 ns

# Memory usage statistics:

# Name                       Memory usage
# Elixir Kernel.byte_size             0 B
# Elixir Kernel.length                0 B - 1.00x memory usage +0 B
# Elixir String.length             3160 B - ∞ x memory usage +3160 B

######################################################################################

# ##### With input 1 Mio Zeros #####
# Name                         ips        average  deviation         median         99th %
# String.duplicate()        345.54        2.89 ms    ±29.09%        2.76 ms        5.20 ms
# :lists.duplicate()         61.97       16.14 ms    ±18.39%       15.32 ms       31.68 ms

# Comparison:
# String.duplicate()        345.54
# :lists.duplicate()         61.97 - 5.58x slower +13.24 ms

# Memory usage statistics:

# Name                  Memory usage
# String.duplicate()      0.00007 MB
# :lists.duplicate()        15.26 MB - 222220.22x memory usage +15.26 MB

# ##### With input 3 Zeros #####
# Name                         ips        average  deviation         median         99th %
# :lists.duplicate()        5.22 M      191.65 ns  ±3851.42%           0 ns         980 ns
# String.duplicate()        4.63 M      216.07 ns  ±5991.38%           0 ns         980 ns

# Comparison:
# :lists.duplicate()        5.22 M
# String.duplicate()        4.63 M - 1.13x slower +24.42 ns

# Memory usage statistics:

# Name                  Memory usage
# :lists.duplicate()            48 B
# String.duplicate()            24 B - 0.50x memory usage -24 B

# ##### With input 30 Zeros #####
# Name                         ips        average  deviation         median         99th %
# String.duplicate()        3.41 M      293.40 ns  ±5036.43%           0 ns         980 ns
# :lists.duplicate()        2.12 M      471.27 ns  ±7813.55%           0 ns         980 ns

# Comparison:
# String.duplicate()        3.41 M
# :lists.duplicate()        2.12 M - 1.61x slower +177.87 ns

# Memory usage statistics:

# Name                  Memory usage
# String.duplicate()            48 B
# :lists.duplicate()           480 B - 10.00x memory usage +432 B

# ##### With input 300 Zeros #####
# Name                         ips        average  deviation         median         99th %
# String.duplicate()      734.43 K        1.36 μs  ±1907.57%        0.98 μs        1.98 μs
# :lists.duplicate()      419.92 K        2.38 μs  ±1224.94%        1.98 μs        3.98 μs

# Comparison:
# String.duplicate()      734.43 K
# :lists.duplicate()      419.92 K - 1.75x slower +1.02 μs

# Memory usage statistics:

# Name                  Memory usage
# String.duplicate()       0.0469 KB
# :lists.duplicate()         4.69 KB - 100.00x memory usage +4.64 KB
