inputs = %{
  "1 Digits Integer as String" => {6, 9},
  "6 Digits Integer as String" => {123_456, 654_321},
  "15 Digits Integer as String" => {123_456_789_012_345, 543_210_987_654_321},
  "22 Digits Integer as String" => {1_234_567_890_123_456_789_012, 9_876_543_210_987_654_321_098},
  "23 Digits Integer as String" =>
    {12_345_678_901_234_567_890_123, 98_765_432_109_876_543_210_987},
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

bench = %{
  # Subtraction -  Integer values
  "Decimal.sub() Int" => fn {l, r} ->
    Decimal.sub(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  end,
  "Apa.sub() Int" => fn {l, r} ->
    Apa.sub({l, 0}, {r, 0})
  end,

  # Subtraction -  Decimalpoint values
  "Decimal.sub() Dec" => fn {l, r} ->
    Decimal.sub(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  end,
  "Apa.sub() Dec" => fn {l, r} ->
    Apa.sub({l, -12}, {r, 12})
  end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 1,
  memory_time: 1,
  print: [fast_warning: false]
  # save: [path: "apa_benchee_path"]
)

bench = %{
  # Multiplication -  Integer values
  "Decimal.mult() Int" => fn {l, r} ->
    Decimal.mult(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  end,
  "Apa.mul() Int" => fn {l, r} ->
    Apa.mul({l, 0}, {r, 0})
  end,

  # Multiplication -  Decimalpoint values
  "Decimal.mult() Dec" => fn {l, r} ->
    Decimal.mult(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  end,
  "Apa.mul() Dec" => fn {l, r} ->
    Apa.mul({l, -12}, {r, 12})
  end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 1,
  memory_time: 1,
  print: [fast_warning: false]
  # save: [path: "apa_benchee_path"]
)

bench = %{
  # Division -  Integer values
  "Decimal.div() Int" => fn {l, r} ->
    Decimal.div(%Decimal{sign: 1, coef: l, exp: 0}, %Decimal{sign: 1, coef: r, exp: 0})
  end,
  "Apa.div() Int" => fn {l, r} ->
    Apa.div({l, 0}, {r, 0})
  end,

  # Division -  Decimalpoint values
  "Decimal.div() Dec" => fn {l, r} ->
    Decimal.div(%Decimal{sign: 1, coef: l, exp: -12}, %Decimal{sign: 1, coef: r, exp: 12})
  end,
  "Apa.div() Dec" => fn {l, r} ->
    Apa.div({l, -12}, {r, 12})
  end
}

Benchee.run(bench,
  inputs: inputs,
  time: 6,
  warmup: 1,
  memory_time: 1,
  print: [fast_warning: false]
  # save: [path: "apa_benchee_path"]
)
