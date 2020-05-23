inputs = %{
  ####
  # "3 Zeros" => {3, 3},
  # "30 Zeros" => {30, 30},
  # "300 Zeros" => {300, 300},
  # "1 Mio Zeros" => {1_000_000, 1_000_000}
  #####
  # "1 Digits Integer as String" => {"3", ['3']},
  # "30 Digits Integer as String" =>
  #   {"123456789012345678901234567890", ['123456789012345678901234567890']}
  # "606 Digits Integer as String" =>
  #   {"123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901"}
  # "6 Digits Integer" => {123_456, 654_321},
  # "42 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012,
  #    987_654_321_012_987_654_321_098_765_432_109_876_543_298},
  # "606 Digits Integer" =>
  #   {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
  #    893_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_999}
  # "3 Digits Integer" => {123, -1},
  # "6 Digits Integer" => {123_456, -3},
  "9 Digits Integer" => {123_456_789, -3},
  "12 Digits Integer" => {123_456_789_012, -3},
  "15 Digits Integer" => {123_456_789_012_345, -3},
  "18 Digits Integer" => {123_456_789_012_345_678, -3},
  "21 Digits Integer" => {123_456_789_012_345_678_901, -3},
  "24 Digits Integer" => {123_456_789_012_345_678_901_234, -3},
  "42 Digits Integer" => {123_456_789_012_345_678_901_234_567_890_123_456_789_012, -3},
  "100 Digits Integer" =>
    {1_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890,
     -3},
  "606 Digits Integer" =>
    {123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_011_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_112_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345_678_901,
     -3}
}

bench = %{
  # "Elixir Kernel.byte_size" => fn {l, r} -> Kernel.byte_size(l) end,
  # "Elixir String.length" => fn {l, r} -> String.length(l) end,
  # "Elixir Kernel.length" => fn {l, r} -> Kernel.length(r) end

  ############
  # "Kernel.length()" => fn {l, r} ->
  #   Kernel.length(r)
  # end,
  # "String.length()" => fn {l, r} ->
  #   String.length(l)
  # end

  ############
  # maybe better :lists.duplicate(scale, ?0) - no its much slower!!!
  # String.duplicate("0", scale) - this is much faster!!! and less memory usage
  # ":lists.duplicate()" => fn {l, r} ->
  #   :lists.duplicate(l, ?0)
  # end,
  # "String.duplicate()" => fn {l, r} ->
  #   String.duplicate("0", l)
  # end

  ############
  # "charlist length" => fn {l, r} ->
  #   Kernel.abs(l) |> Integer.to_charlist() |> Kernel.length()
  # end,
  # "String length" => fn {l, r} ->
  #   Kernel.abs(l) |> Integer.to_string() |> String.length()
  # end,
  # "String byte_size" => fn {l, r} ->
  #   Kernel.abs(l) |> Integer.to_string() |> Kernel.byte_size()
  # end

  ############
  # "Integer.to_string()             :" => fn {l, r} ->
  #   l |> Integer.to_string()
  # end,
  # "Kernel.to_string()              :" => fn {l, r} ->
  #   l |> Kernel.to_string()
  # end,
  # "to_charlist |> iodata_to_binary :" => fn {l, r} ->
  #   l |> Integer.to_charlist() |> IO.iodata_to_binary()
  # end

  # the fastest before 15 digits
  "Create Dec String with            List :" => fn {l, r} ->
    list = l |> Integer.to_charlist()
    len = Kernel.length(list)

    List.insert_at(list, len + r, ?.) |> IO.iodata_to_binary()
  end,
  # the winner after 15 digits !!!
  "Create Dec String with       Strings 1 :" => fn {l, r} ->
    int_str = l |> Kernel.to_string()
    len = abs(r)
    <<int::binary-size(len), float::binary>> = int_str
    "#{int}.#{float}"
    # int <> "." <> float
  end,
  "Create Dec String with       Strings 2 :" => fn {l, r} ->
    int_str = l |> Kernel.to_string()
    len = abs(r)
    <<int::binary-size(len), float::binary>> = int_str
    int <> "." <> float
  end
  # much slower
  # "Create Dec String with Strings.split :" => fn {l, r} ->
  #   int_str = l |> Kernel.to_string()
  #   len = abs(r)
  #   {d1, d2} = String.split_at(int_str, len)
  #   "#{d1}.#{d2}"
  # end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 6,
  memory_time: 1,
  print: [fast_warning: false]
)

############################### Create Dec String ###################################
##### With input 100 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :      539.74 K        1.85 μs   ±147.29%           2 μs           3 μs
# Create Dec String with       Strings 2 :      535.96 K        1.87 μs   ±355.06%           2 μs           3 μs
# Create Dec String with            List :      278.99 K        3.58 μs   ±409.37%           3 μs           6 μs

# Comparison:
# Create Dec String with       Strings 1 :      539.74 K
# Create Dec String with       Strings 2 :      535.96 K - 1.01x slower +0.0131 μs
# Create Dec String with            List :      278.99 K - 1.93x slower +1.73 μs

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           240 B
# Create Dec String with       Strings 2 :           240 B - 1.00x memory usage +0 B
# Create Dec String with            List :          3216 B - 13.40x memory usage +2976 B

# **All measurements for memory usage were the same**

# ##### With input 12 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with            List :        1.52 M      657.89 ns  ±5241.38%        1000 ns        1000 ns
# Create Dec String with       Strings 1 :        1.51 M      664.40 ns  ±4972.40%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.49 M      672.02 ns  ±4807.66%        1000 ns        2000 ns

# Comparison:
# Create Dec String with            List :        1.52 M
# Create Dec String with       Strings 1 :        1.51 M - 1.01x slower +6.51 ns
# Create Dec String with       Strings 2 :        1.49 M - 1.02x slower +14.13 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with            List :           384 B
# Create Dec String with       Strings 1 :           216 B - 0.56x memory usage -168 B
# Create Dec String with       Strings 2 :           216 B - 0.56x memory usage -168 B

# **All measurements for memory usage were the same**

# ##### With input 15 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.47 M      680.84 ns  ±4883.10%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.41 M      710.53 ns  ±4753.75%        1000 ns        2000 ns
# Create Dec String with            List :        1.37 M      727.56 ns  ±4331.18%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.47 M
# Create Dec String with       Strings 2 :        1.41 M - 1.04x slower +29.69 ns
# Create Dec String with            List :        1.37 M - 1.07x slower +46.72 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           216 B
# Create Dec String with       Strings 2 :           216 B - 1.00x memory usage +0 B
# Create Dec String with            List :           480 B - 2.22x memory usage +264 B

# **All measurements for memory usage were the same**

# ##### With input 18 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.42 M      704.76 ns  ±3341.86%        1000 ns        1000 ns
# Create Dec String with       Strings 2 :        1.39 M      720.80 ns  ±3376.14%        1000 ns        1000 ns
# Create Dec String with            List :        1.25 M      798.67 ns  ±3805.51%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.42 M
# Create Dec String with       Strings 2 :        1.39 M - 1.02x slower +16.04 ns
# Create Dec String with            List :        1.25 M - 1.13x slower +93.91 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           224 B
# Create Dec String with       Strings 2 :           224 B - 1.00x memory usage +0 B
# Create Dec String with            List :           584 B - 2.61x memory usage +360 B

# **All measurements for memory usage were the same**

# ##### With input 21 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.18 M      845.13 ns  ±2625.83%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.13 M      883.27 ns  ±2654.88%        1000 ns        2000 ns
# Create Dec String with            List :        1.04 M      961.59 ns  ±3599.31%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.18 M
# Create Dec String with       Strings 2 :        1.13 M - 1.05x slower +38.13 ns
# Create Dec String with            List :        1.04 M - 1.14x slower +116.46 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           232 B
# Create Dec String with       Strings 2 :           232 B - 1.00x memory usage +0 B
# Create Dec String with            List :           680 B - 2.93x memory usage +448 B

# **All measurements for memory usage were the same**

# ##### With input 24 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.20 M      831.54 ns  ±1480.85%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.19 M      837.31 ns  ±1485.04%        1000 ns        2000 ns
# Create Dec String with            List :        1.05 M      949.99 ns  ±2282.18%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.20 M
# Create Dec String with       Strings 2 :        1.19 M - 1.01x slower +5.77 ns
# Create Dec String with            List :        1.05 M - 1.14x slower +118.44 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           232 B
# Create Dec String with       Strings 2 :           232 B - 1.00x memory usage +0 B
# Create Dec String with            List :           784 B - 3.38x memory usage +552 B

# **All measurements for memory usage were the same**

# ##### With input 42 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :     1015.19 K        0.99 μs  ±1303.69%           1 μs           2 μs
# Create Dec String with       Strings 2 :      992.13 K        1.01 μs  ±1273.30%           1 μs           2 μs
# Create Dec String with            List :      659.14 K        1.52 μs  ±1263.57%           1 μs           2 μs

# Comparison:
# Create Dec String with       Strings 1 :     1015.19 K
# Create Dec String with       Strings 2 :      992.13 K - 1.02x slower +0.0229 μs
# Create Dec String with            List :      659.14 K - 1.54x slower +0.53 μs

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           272 B
# Create Dec String with       Strings 2 :           272 B - 1.00x memory usage +0 B
# Create Dec String with            List :          1376 B - 5.06x memory usage +1104 B

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :       49.99 K       20.00 μs    ±68.71%          18 μs          45 μs
# Create Dec String with       Strings 2 :       48.94 K       20.43 μs    ±49.48%          19 μs          64 μs
# Create Dec String with            List :       33.53 K       29.83 μs    ±27.49%          29 μs          57 μs

# Comparison:
# Create Dec String with       Strings 1 :       49.99 K
# Create Dec String with       Strings 2 :       48.94 K - 1.02x slower +0.43 μs
# Create Dec String with            List :       33.53 K - 1.49x slower +9.82 μs

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           240 B
# Create Dec String with       Strings 2 :           240 B - 1.00x memory usage +0 B
# Create Dec String with            List :          9712 B - 40.47x memory usage +9472 B

# **All measurements for memory usage were the same**

# ##### With input 9 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with            List :        1.94 M      516.49 ns  ±6064.09%           0 ns        1000 ns
# Create Dec String with       Strings 2 :        1.79 M      559.71 ns  ±3208.97%           0 ns        2000 ns
# Create Dec String with       Strings 1 :        1.72 M      581.03 ns  ±3077.63%           0 ns        2000 ns

# Comparison:
# Create Dec String with            List :        1.94 M
# Create Dec String with       Strings 2 :        1.79 M - 1.08x slower +43.22 ns
# Create Dec String with       Strings 1 :        1.72 M - 1.12x slower +64.54 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with            List :           288 B
# Create Dec String with       Strings 2 :           208 B - 0.72x memory usage -80 B
# Create Dec String with       Strings 1 :           208 B - 0.72x memory usage -80 B
#   # "Elixir String.length" => fn {l, r} -> String.length(l) end,
#   # "Elixir Kernel.length" => fn {l, r} -> Kernel.length(r) end

#   ############
#   # "Kernel.length()" => fn {l, r} ->
#   #   Kernel.length(r)
#   # end,
#   # "String.length()" => fn {l, r} ->
#   #   String.length(l)
#   # end

#   ############
#   # maybe better :lists.duplicate(scale, ?0) - no its much slower!!!
#   # String.duplicate("0", scale) - this is much faster!!! and less memory usage
#   # ":lists.duplicate()" => fn {l, r} ->
#   #   :lists.duplicate(l, ?0)
#   # end,
#   # "String.duplicate()" => fn {l, r} ->
#   #   String.duplicate("0", l)
#   # end

#   ############
#   # "charlist length" => fn {l, r} ->
#   #   Kernel.abs(l) |> Integer.to_charlist() |> Kernel.length()
#   # end,
#   # "String length" => fn {l, r} ->
#   #   Kernel.abs(l) |> Integer.to_string() |> String.length()
#   # end,
#   # "String byte_size" => fn {l, r} ->
#   #   Kernel.abs(l) |> Integer.to_string() |> Kernel.byte_size()
#   # end

#   ############
#   # "Integer.to_string()             :" => fn {l, r} ->
#   #   l |> Integer.to_string()
#   # end,
#   # "Kernel.to_string()              :" => fn {l, r} ->
#   #   l |> Kernel.to_string()
#   # end,
#   # "to_charlist |> iodata_to_binary :" => fn {l, r} ->
#   #   l |> Integer.to_charlist() |> IO.iodata_to_binary()
#   # end

#   # the fastest before 15 digits
#   "Create Dec String with            List :" => fn {l, r} ->
#     list = l |> Integer.to_charlist()
#     len = Kernel.length(list)

#     List.insert_at(list, len + r, ?.) |> IO.iodata_to_binary()
#   end,
#   "Create Dec String with       Strings 1 :" => fn {l, r} ->
#     int_str = l |> Kernel.to_string()
#     len = abs(r)
#     <<int::binary-size(len), float::binary>> = int_str
#     "#{int}.#{float}"
#     # int <> "." <> float
#   end,
#   # the winner after 15 digits !!!
#   "Create Dec String with       Strings 2 :" => fn {l, r} ->
#     int_str = l |> Kernel.to_string()
#     len = abs(r)
#     <<int::binary-size(len), float::binary>> = int_str
#     int <> "." <> float
#   end
#   # much slower
#   # "Create Dec String with Strings.split :" => fn {l, r} ->
#   #   int_str = l |> Kernel.to_string()
#   #   len = abs(r)
#   #   {d1, d2} = String.split_at(int_str, len)
#   #   "#{d1}.#{d2}"
#   # end
# }

# Benchee.run(bench,
#   inputs: inputs,
#   time: 6,
#   warmup: 6,
#   memory_time: 1,
#   print: [fast_warning: false]
# )

# ############################### Create Dec String ###################################
# ##### With input 100 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :      539.74 K        1.85 μs   ±147.29%           2 μs           3 μs
# Create Dec String with       Strings 2 :      535.96 K        1.87 μs   ±355.06%           2 μs           3 μs
# Create Dec String with            List :      278.99 K        3.58 μs   ±409.37%           3 μs           6 μs

# Comparison:
# Create Dec String with       Strings 1 :      539.74 K
# Create Dec String with       Strings 2 :      535.96 K - 1.01x slower +0.0131 μs
# Create Dec String with            List :      278.99 K - 1.93x slower +1.73 μs

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           240 B
# Create Dec String with       Strings 2 :           240 B - 1.00x memory usage +0 B
# Create Dec String with            List :          3216 B - 13.40x memory usage +2976 B

# **All measurements for memory usage were the same**

# ##### With input 12 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with            List :        1.52 M      657.89 ns  ±5241.38%        1000 ns        1000 ns
# Create Dec String with       Strings 1 :        1.51 M      664.40 ns  ±4972.40%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.49 M      672.02 ns  ±4807.66%        1000 ns        2000 ns

# Comparison:
# Create Dec String with            List :        1.52 M
# Create Dec String with       Strings 1 :        1.51 M - 1.01x slower +6.51 ns
# Create Dec String with       Strings 2 :        1.49 M - 1.02x slower +14.13 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with            List :           384 B
# Create Dec String with       Strings 1 :           216 B - 0.56x memory usage -168 B
# Create Dec String with       Strings 2 :           216 B - 0.56x memory usage -168 B

# **All measurements for memory usage were the same**

# ##### With input 15 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.47 M      680.84 ns  ±4883.10%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.41 M      710.53 ns  ±4753.75%        1000 ns        2000 ns
# Create Dec String with            List :        1.37 M      727.56 ns  ±4331.18%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.47 M
# Create Dec String with       Strings 2 :        1.41 M - 1.04x slower +29.69 ns
# Create Dec String with            List :        1.37 M - 1.07x slower +46.72 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           216 B
# Create Dec String with       Strings 2 :           216 B - 1.00x memory usage +0 B
# Create Dec String with            List :           480 B - 2.22x memory usage +264 B

# **All measurements for memory usage were the same**

# ##### With input 18 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.42 M      704.76 ns  ±3341.86%        1000 ns        1000 ns
# Create Dec String with       Strings 2 :        1.39 M      720.80 ns  ±3376.14%        1000 ns        1000 ns
# Create Dec String with            List :        1.25 M      798.67 ns  ±3805.51%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.42 M
# Create Dec String with       Strings 2 :        1.39 M - 1.02x slower +16.04 ns
# Create Dec String with            List :        1.25 M - 1.13x slower +93.91 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           224 B
# Create Dec String with       Strings 2 :           224 B - 1.00x memory usage +0 B
# Create Dec String with            List :           584 B - 2.61x memory usage +360 B

# **All measurements for memory usage were the same**

# ##### With input 21 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.18 M      845.13 ns  ±2625.83%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.13 M      883.27 ns  ±2654.88%        1000 ns        2000 ns
# Create Dec String with            List :        1.04 M      961.59 ns  ±3599.31%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.18 M
# Create Dec String with       Strings 2 :        1.13 M - 1.05x slower +38.13 ns
# Create Dec String with            List :        1.04 M - 1.14x slower +116.46 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           232 B
# Create Dec String with       Strings 2 :           232 B - 1.00x memory usage +0 B
# Create Dec String with            List :           680 B - 2.93x memory usage +448 B

# **All measurements for memory usage were the same**

# ##### With input 24 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :        1.20 M      831.54 ns  ±1480.85%        1000 ns        2000 ns
# Create Dec String with       Strings 2 :        1.19 M      837.31 ns  ±1485.04%        1000 ns        2000 ns
# Create Dec String with            List :        1.05 M      949.99 ns  ±2282.18%        1000 ns        1000 ns

# Comparison:
# Create Dec String with       Strings 1 :        1.20 M
# Create Dec String with       Strings 2 :        1.19 M - 1.01x slower +5.77 ns
# Create Dec String with            List :        1.05 M - 1.14x slower +118.44 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           232 B
# Create Dec String with       Strings 2 :           232 B - 1.00x memory usage +0 B
# Create Dec String with            List :           784 B - 3.38x memory usage +552 B

# **All measurements for memory usage were the same**

# ##### With input 42 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :     1015.19 K        0.99 μs  ±1303.69%           1 μs           2 μs
# Create Dec String with       Strings 2 :      992.13 K        1.01 μs  ±1273.30%           1 μs           2 μs
# Create Dec String with            List :      659.14 K        1.52 μs  ±1263.57%           1 μs           2 μs

# Comparison:
# Create Dec String with       Strings 1 :     1015.19 K
# Create Dec String with       Strings 2 :      992.13 K - 1.02x slower +0.0229 μs
# Create Dec String with            List :      659.14 K - 1.54x slower +0.53 μs

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           272 B
# Create Dec String with       Strings 2 :           272 B - 1.00x memory usage +0 B
# Create Dec String with            List :          1376 B - 5.06x memory usage +1104 B

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with       Strings 1 :       49.99 K       20.00 μs    ±68.71%          18 μs          45 μs
# Create Dec String with       Strings 2 :       48.94 K       20.43 μs    ±49.48%          19 μs          64 μs
# Create Dec String with            List :       33.53 K       29.83 μs    ±27.49%          29 μs          57 μs

# Comparison:
# Create Dec String with       Strings 1 :       49.99 K
# Create Dec String with       Strings 2 :       48.94 K - 1.02x slower +0.43 μs
# Create Dec String with            List :       33.53 K - 1.49x slower +9.82 μs

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with       Strings 1 :           240 B
# Create Dec String with       Strings 2 :           240 B - 1.00x memory usage +0 B
# Create Dec String with            List :          9712 B - 40.47x memory usage +9472 B

# **All measurements for memory usage were the same**

# ##### With input 9 Digits Integer #####
# Name                                               ips        average  deviation         median         99th %
# Create Dec String with            List :        1.94 M      516.49 ns  ±6064.09%           0 ns        1000 ns
# Create Dec String with       Strings 2 :        1.79 M      559.71 ns  ±3208.97%           0 ns        2000 ns
# Create Dec String with       Strings 1 :        1.72 M      581.03 ns  ±3077.63%           0 ns        2000 ns

# Comparison:
# Create Dec String with            List :        1.94 M
# Create Dec String with       Strings 2 :        1.79 M - 1.08x slower +43.22 ns
# Create Dec String with       Strings 1 :        1.72 M - 1.12x slower +64.54 ns

# Memory usage statistics:

# Name                                        Memory usage
# Create Dec String with            List :           288 B
# Create Dec String with       Strings 2 :           208 B - 0.72x memory usage -80 B
# Create Dec String with       Strings 1 :           208 B - 0.72x memory usage -80 B
############## integer -> to_string ###################

# ##### With input 42 Digits Integer #####
# Name                                        ips        average  deviation         median         99th %
# Integer.to_string()             :        1.48 M      673.95 ns  ±2653.58%         980 ns         980 ns
# Kernel.to_string()              :        1.47 M      681.98 ns   ±300.00%         980 ns         980 ns
# to_charlist |> iodata_to_binary :        1.16 M      865.13 ns  ±2591.12%         980 ns         980 ns

# Comparison:
# Integer.to_string()             :        1.48 M
# Kernel.to_string()              :        1.47 M - 1.01x slower +8.03 ns
# to_charlist |> iodata_to_binary :        1.16 M - 1.28x slower +191.18 ns

# Memory usage statistics:

# Name                                 Memory usage
# Integer.to_string()             :            64 B
# Kernel.to_string()              :            64 B - 1.00x memory usage +0 B
# to_charlist |> iodata_to_binary :           736 B - 11.50x memory usage +672 B

# **All measurements for memory usage were the same**

# ##### With input 6 Digits Integer #####
# Name                                        ips        average  deviation         median         99th %
# Integer.to_string()             :        4.60 M      217.53 ns ±12756.40%           0 ns         980 ns
# Kernel.to_string()              :        4.07 M      245.65 ns  ±7216.35%           0 ns         980 ns
# to_charlist |> iodata_to_binary :        3.43 M      291.50 ns  ±9264.71%           0 ns         980 ns

# Comparison:
# Integer.to_string()             :        4.60 M
# Kernel.to_string()              :        4.07 M - 1.13x slower +28.12 ns
# to_charlist |> iodata_to_binary :        3.43 M - 1.34x slower +73.98 ns

# Memory usage statistics:

# Name                                 Memory usage
# Integer.to_string()             :            24 B
# Kernel.to_string()              :            24 B - 1.00x memory usage +0 B
# to_charlist |> iodata_to_binary :           120 B - 5.00x memory usage +96 B

# **All measurements for memory usage were the same**

# ##### With input 606 Digits Integer #####
# Name                                        ips        average  deviation         median         99th %
# Integer.to_string()             :       53.82 K       18.58 μs    ±34.81%       17.98 μs       37.98 μs
# Kernel.to_string()              :       53.81 K       18.59 μs    ±35.54%       17.98 μs       38.98 μs
# to_charlist |> iodata_to_binary :       46.89 K       21.32 μs    ±23.69%       19.98 μs       45.98 μs

# Comparison:
# Integer.to_string()             :       53.82 K
# Kernel.to_string()              :       53.81 K - 1.00x slower +0.00587 μs
# to_charlist |> iodata_to_binary :       46.89 K - 1.15x slower +2.75 μs

# Memory usage statistics:

# Name                                 Memory usage
# Integer.to_string()             :            48 B
# Kernel.to_string()              :            48 B - 1.00x memory usage +0 B
# to_charlist |> iodata_to_binary :            48 B - 1.00x memory usage +0 B

############################### integer as string length ###################################
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

############################## duplicate a number of zeros ########################################################

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
