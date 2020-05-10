defmodule ApaDecimalTest do
  use ExUnit.Case, async: true

  # import Apa
  # import Kernel, except: [+: 2, -: 2, *: 2, /: 2, to_string: 1]

  test "parse/1" do
    assert Apa.parse("123") == {123, 0}
    assert Apa.parse("+123") == {123, 0}
    assert Apa.parse("-123") == {-123, 0}
    assert Apa.parse("-123x") == {-123, 0}
    assert Apa.parse("-123X") == {-123, 0}

    # Apa differ here - I think it's better to have the most possible correct internal number
    # mathematically both numbers are equal: Apa.comp({123, 0}, {1230, -1}) == 0
    # assert Apa.parse("123.0") == {1230, -1}
    # assert Apa.parse("+123.0") == {1230, -1}
    # assert Apa.parse("-123.0") == {-1230, -1}
    # assert Apa.parse("-123.0x") == {-1230, -1}
    assert Apa.parse("123.0") == {123, 0}
    assert Apa.parse("+123.0") == {123, 0}
    assert Apa.parse("-123.0") == {-123, 0}
    assert Apa.parse("-123.0x") == {-123, 0}

    assert Apa.parse("1.5") == {15, -1}
    assert Apa.parse("+1.5") == {15, -1}
    assert Apa.parse("-1.5") == {-15, -1}
    assert Apa.parse("-1.5x") == {-15, -1}

    assert Apa.parse("0") == {0, 0}
    assert Apa.parse("+0") == {0, 0}
    assert Apa.parse("-0") == {-0, 0}

    assert Apa.parse("0.") == {0, 0}
    assert Apa.parse("0.x") == {0, 0}

    # Apa differ here - I think it's better to have a digit in the beginning of a string
    # assert Apa.parse(".0") == {0, -1}
    # assert Apa.parse(".0x") == {0, -1}
    assert Apa.parse(".0") == :error
    assert Apa.parse(".0x") == :error

    # Apa differ here - I think it's better to have the most possible correct internal number
    # mathematically both numbers are equal: Apa.comp({0, 0}, {0, -1}) == 0
    # assert Apa.parse("0.0") == {0, -1}
    # assert Apa.parse("-0.0") == {-0, -1}
    # assert Apa.parse("+0.0") == {0, -1}
    # assert Apa.parse("0.0.0") == {0, -1}
    # assert Apa.parse("-0.0.0") == {-0, -1}
    # assert Apa.parse("+0.0.0") == {0, -1}
    # assert Apa.parse("1230e13") == {1230, 13}
    # assert Apa.parse("+1230e+2") == {1230, 2}
    # assert Apa.parse("-1230e-2") == {-1230, -2}
    # assert Apa.parse("-1230e-2x") == {-1230, -2}
    # assert Apa.parse("1230.00e13") == {123_000, 11}
    # assert Apa.parse("+1230.1230e+5") == {12_301_230, 1}
    # assert Apa.parse("-1230.01010e-5") == {-123_001_010, -10}
    # assert Apa.parse("-1230.01010e-5x") == {-123_001_010, -10}

    assert Apa.parse("0.0") == {0, 0}
    assert Apa.parse("-0.0") == {0, 0}
    assert Apa.parse("+0.0") == {0, 0}
    assert Apa.parse("0.0.0") == {0, 0}
    assert Apa.parse("-0.0.0") == {0, 0}
    assert Apa.parse("+0.0.0") == {0, 0}
    assert Apa.parse("1230e13") == {123, 14}
    assert Apa.parse("+1230e+2") == {123, 3}
    assert Apa.parse("-1230e-2") == {-123, -1}
    assert Apa.parse("-1230e-2x") == {-123, -1}
    assert Apa.parse("1230.00e13") == {123, 14}
    assert Apa.parse("+1230.1230e+5") == {1_230_123, 2}
    assert Apa.parse("-1230.01010e-5") == {-12_300_101, -9}
    assert Apa.parse("-1230.01010e-5x") == {-12_300_101, -9}

    assert Apa.parse("0e0") == {0, 0}
    assert Apa.parse("+0e-0") == {0, 0}
    assert Apa.parse("-0e+0") == {-0, 0}
    assert Apa.parse("-0e+0x") == {-0, 0}

    # not necessary with Apa - see doc
    # assert Apa.parse("inf") == {:inf, 0}
    # assert Apa.parse("infinity") == {:inf, 0}
    # assert Apa.parse("INFinity") == {:inf, 0}
    # assert Apa.parse("INFINITY") == {:inf, 0}
    # assert Apa.parse("nan") == {:NaN, 0}
    # assert Apa.parse("-NaN") == {-:NaN, 0}
    # assert Apa.parse("nAn") == {:NaN, 0}

    assert Apa.parse("42.+42") == {42, 0}

    assert Apa.parse("") == :error
    assert Apa.parse("a") == :error
    assert Apa.parse("test") == :error
    assert Apa.parse("e0") == :error
  end

  # not necessary with Apa - see doc
  # test "nan?/1" do
  #   assert Apa.nan?(~d"nan")
  #   refute Apa.nan?(~d"0")
  # end

  # not necessary with Apa - see doc
  # test "inf?/1" do
  #   assert Apa.inf?(~d"inf")
  #   refute Apa.inf?(~d"0")
  # end

  # not supported with Apa at the moment
  # test "is_Apa/1 expression" do
  #   assert Apa.is_Apa(~d"nan")
  #   assert Apa.is_Apa(~d"inf")
  #   assert Apa.is_Apa(~d"0")
  #   refute Apa.is_Apa(42)
  #   refute Apa.is_Apa("42")
  # end

  # not supported with Apa at the moment
  # if function_exported?(:erlang, :is_map_key, 2) do
  #   defp Apa?(struct) when Apa.is_Apa(struct), do: true
  #   defp Apa?(_other), do: false

  #   test "is_Apa/1 guard" do
  #     assert Apa?(~d"nan")
  #     assert Apa?(~d"inf")
  #     assert Apa?(~d"0")
  #     refute Apa?(42)
  #     refute Apa?("42")
  #   end
  # end

  test "new/1 conversion" do
    assert Apa.new({-3, 2}) == {-3, 2}
    assert Apa.new(123) == {123, 0}

    assert_raise ArgumentError, fn ->
      Apa.new(:atom)
    end
  end

  test "new/1 parsing" do
    assert Apa.new("123") == {123, 0}

    assert Apa.new("123.45") == {12_345, -2}

    assert Apa.new("") == :error

    # Apa differ here - I think if parsing is possible, new() could use parsing
    # with ignoring the rest of the string
    # assert_raise Error, fn ->
    #   Apa.new("123x")
    # end
    assert Apa.new("123x") == {123, 0}
    assert Apa.new("test") == :error
    assert Apa.new("e0") == :error
    assert Apa.new("42.+42") == {42, 0}
    assert Apa.new("42e0.0") == {42, 0}
  end

  test "from_float/1" do
    assert Apa.from_float(123.0) == {123, 0}
    assert Apa.from_float(0.1) == {1, -1}
    assert Apa.from_float(0.000015) == {15, -6}
    assert Apa.from_float(-1.5) == {-15, -1}
  end

  test "cast/1" do
    assert Apa.cast(123) == {:ok, {123, 0}}
    assert Apa.cast(123.0) == {:ok, {123, 0}}
    assert Apa.cast("123") == {:ok, {123, 0}}
    assert Apa.cast({123, 0}) == {:ok, {123, 0}}

    assert Apa.cast("one two three") == {:error, "one two three"}
    assert Apa.cast("e0") == {:error, "e0"}
    assert Apa.cast(:one_two_three) == {:error, :one_two_three}
  end

  test "abs/1" do
    assert Apa.abs(Apa.new("123")) == {123, 0}
    assert Apa.abs(Apa.new("-123")) == {123, 0}
    assert Apa.abs(Apa.new("-12.5e2")) == {125, 1}
    assert Apa.abs(Apa.new("-42e-42")) == {42, -42}

    # not supported with Apa at the moment
    # assert Apa.abs(Apa.new("-inf")) == {:inf, 0}
    # assert Apa.abs(Apa.new("nan")) == {:NaN, 0}
  end

  test "add/2" do
    assert Apa.add("0", "0") == Apa.to_string({0, 0})
    assert Apa.add("1", "1") == Apa.to_string({2, 0})
    assert Apa.add("1.3e3", "2.4e2") == Apa.to_string({154, 1})
    assert Apa.add("0.42", "-1.5") == Apa.to_string({-108, -2})
    assert Apa.add("-2e-2", "-2e-2") == Apa.to_string({-4, -2})
    assert Apa.add("-0", "0") == Apa.to_string({0, 0})
    assert Apa.add("-0", "-0") == Apa.to_string({0, 0})
    assert Apa.add("2", "-2") == Apa.to_string({0, 0})

    # not supported with Apa at the moment
    # assert Apa.add("5", "nan") == :NaN, 0)
    # assert Apa.add("inf", "inf") == :inf, 0)
    # assert Apa.add("-inf", "-inf") == d(-1, :inf, 0)

    # assert Apa.add(:inf, 2), :inf, 5)) == :inf, 5)

    # Context.with(%Context{precision: 5, rounding: :floor}, fn ->
    #   Apa.add("2", "-2") == d(-1, 0, 0)
    # end)

    # assert Apa.add("inf", "5") == d(1, :inf, 0)
    # assert Apa.add("5", "-inf") == d(-1, :inf, 0)

    # assert_raise Error, fn ->
    #   Apa.add("inf", "-inf")
    # end

    # assert_raise ArgumentError, ~r/implicit conversion of 2.0 to Decimal is not allowed/, fn ->
    #   Apa.add(1, 2.0)
    # end

    # in Apa it's allowed
    assert Apa.add(1, 2.0) == Apa.to_string({3, 0})
  end

  test "sub/2" do
    assert Apa.sub("0", "0") == Apa.to_string({0, 0})
    assert Apa.sub("1", "2") == Apa.to_string({-1, 0})
    assert Apa.sub("1.3e3", "2.4e2") == Apa.to_string({106, 1})
    assert Apa.sub("0.42", "-1.5") == Apa.to_string({192, -2})
    assert Apa.sub("2e-2", "-2e-2") == Apa.to_string({4, -2})
    assert Apa.sub("-0", "0") == Apa.to_string({0, 0})
    assert Apa.sub("-0", "-0") == Apa.to_string({0, 0})

    # not supported with Apa at the moment
    # assert Apa.add("5", "nan") == d(1, :NaN, 0)

    # Context.with(%Context{precision: 5, rounding: :floor}, fn ->
    #   Apa.sub(~d"2", ~d"2") == d(-1, 0, 0)
    # end)

    # assert Apa.sub(~d"inf", ~d"5") == d(1, :inf, 0)
    # assert Apa.sub(~d"5", ~d"-inf") == d(1, :inf, 0)

    # assert_raise Error, fn ->
    #   Apa.sub(~d"inf", ~d"inf")
    # end
  end

  # test "compare/2" do
  #   assert Apa.compare(~d"420", ~d"42e1") == :eq
  #   assert Apa.compare(~d"1", ~d"0") == :gt
  #   assert Apa.compare(~d"0", ~d"1") == :lt
  #   assert Apa.compare(~d"0", ~d"-0") == :eq

  #   assert Apa.compare(~d"-inf", ~d"inf") == :lt
  #   assert Apa.compare(~d"inf", ~d"-inf") == :gt
  #   assert Apa.compare(~d"inf", ~d"0") == :gt
  #   assert Apa.compare(~d"-inf", ~d"0") == :lt
  #   assert Apa.compare(~d"0", ~d"inf") == :lt
  #   assert Apa.compare(~d"0", ~d"-inf") == :gt

  #   assert Apa.compare("Inf", "Inf") == :eq

  #   assert_raise Error, fn ->
  #     Apa.compare(~d"nan", ~d"0")
  #   end

  #   assert_raise Error, fn ->
  #     Apa.compare(~d"0", ~d"nan")
  #   end
  # end

  # test "equal?/2" do
  #   assert Apa.equal?(~d"420", ~d"42e1")
  #   refute Apa.equal?(~d"1", ~d"0")
  #   refute Apa.equal?(~d"0", ~d"1")
  #   assert Apa.equal?(~d"0", ~d"-0")
  #   refute Apa.equal?(~d"nan", ~d"1")
  #   refute Apa.equal?(~d"1", ~d"nan")
  # end

  # test "eq/2?" do
  #   assert Apa.eq?(~d"420", ~d"42e1")
  #   refute Apa.eq?(~d"1", ~d"0")
  #   refute Apa.eq?(~d"0", ~d"1")
  #   assert Apa.eq?(~d"0", ~d"-0")
  #   refute Apa.eq?(~d"nan", ~d"1")
  #   refute Apa.eq?(~d"1", ~d"nan")
  # end

  # test "gt?/2" do
  #   refute Apa.gt?(~d"420", ~d"42e1")
  #   assert Apa.gt?(~d"1", ~d"0")
  #   refute Apa.gt?(~d"0", ~d"1")
  #   refute Apa.gt?(~d"0", ~d"-0")
  #   refute Apa.gt?(~d"nan", ~d"1")
  #   refute Apa.gt?(~d"1", ~d"nan")
  # end

  # test "lt?/2" do
  #   refute Apa.lt?(~d"420", ~d"42e1")
  #   refute Apa.lt?(~d"1", ~d"0")
  #   assert Apa.lt?(~d"0", ~d"1")
  #   refute Apa.lt?(~d"0", ~d"-0")
  #   refute Apa.lt?(~d"nan", ~d"1")
  #   refute Apa.lt?(~d"1", ~d"nan")
  # end

  test "div/2" do
    # not supported with Apa at the moment
    # Context.with(%Context{precision: 5, rounding: :half_up}, fn ->
    #   assert Apa.div(~d"1", ~d"3") == d(1, 33333, -5)
    #   assert Apa.div(~d"42", ~d"2") == d(1, 21, 0)
    #   assert Apa.div(~d"123", ~d"12345") == d(1, 99635, -7)
    #   assert Apa.div(~d"123", ~d"123") == d(1, 1, 0)
    #   assert Apa.div(~d"-1", ~d"5") == d(-1, 2, -1)
    #   assert Apa.div(~d"-1", ~d"-1") == d(1, 1, 0)
    #   assert Apa.div(~d"2", ~d"-5") == d(-1, 4, -1)
    # end)

    # Context.with(%Context{precision: 2, rounding: :half_up}, fn ->
    #   assert Apa.div(~d"31", ~d"2") == d(1, 16, 0)
    # end)

    # Context.with(%Context{precision: 2, rounding: :floor}, fn ->
    #   assert Apa.div(~d"31", ~d"2") == d(1, 15, 0)
    # end)

    assert Apa.div("0", "3") == Apa.to_string({0, 0})
    assert Apa.div("-0", "3") == Apa.to_string({0, 0})
    assert Apa.div("0", "-3") == Apa.to_string({0, 0})

    # not supported with Apa at the moment
    # assert Apa.div("nan", "2") == d(1, :NaN, 0)

    # assert Apa.div("-inf", "-2") == d(1, :inf, 0)
    # assert Apa.div("5", "-inf") == d(-1, 0, 0)

    # assert_raise Error, fn ->
    #   Apa.div(~d"inf", ~d"inf")
    # end

    # same result raise error - a little different kind of error and message
    # assert_raise Error, "invalid_operation: 0 / 0", fn ->
    #   Apa.div("0", "-0")
    # end

    # assert_raise Error, "division_by_zero", fn ->
    #   Apa.div("1", "0")
    # end

    assert_raise ArgumentError,
                 "Impossible operation - division by zero - 0 / 0 - see doc.",
                 fn ->
                   Apa.div("0", "-0")
                 end

    assert_raise ArgumentError,
                 "Impossible operation - division by zero - divisor == 0 - see doc.",
                 fn ->
                   Apa.div("1", "0")
                 end
  end

  # not supported with Apa at the moment
  # but could be easely run as - for example:
  # Apa.div("1", "0.3", -1, 0) == "3"
  # test "div_int/2" do
  #   assert Apa.div_int(~d"1", ~d"0.3") == d(1, 3, 0)
  #   assert Apa.div_int(~d"2", ~d"3") == d(1, 0, 0)
  #   assert Apa.div_int(~d"42", ~d"2") == d(1, 21, 0)
  #   assert Apa.div_int(~d"123", ~d"23") == d(1, 5, 0)
  #   assert Apa.div_int(~d"123", ~d"-23") == d(-1, 5, 0)
  #   assert Apa.div_int(~d"-123", ~d"23") == d(-1, 5, 0)
  #   assert Apa.div_int(~d"-123", ~d"-23") == d(1, 5, 0)
  #   assert Apa.div_int(~d"1", ~d"0.3") == d(1, 3, 0)
  #   assert Apa.div_int(~d"4", ~d"8") == d(1, 0, 0)

  #   assert Apa.div_int(~d"0", ~d"3") == d(1, 0, 0)
  #   assert Apa.div_int(~d"-0", ~d"3") == d(-1, 0, 0)
  #   assert Apa.div_int(~d"0", ~d"-3") == d(-1, 0, 0)
  #   assert Apa.div_int(~d"nan", ~d"2") == d(1, :NaN, 0)

  #   assert Apa.div_int(~d"-inf", ~d"-2") == d(1, :inf, 0)
  #   assert Apa.div_int(~d"5", ~d"-inf") == d(-1, 0, 0)

  #   assert_raise Error, fn ->
  #     Apa.div_int(~d"inf", ~d"inf")
  #   end

  #   assert_raise Error, fn ->
  #     Apa.div_int(~d"0", ~d"-0")
  #   end
  # end

  # test "rem/2" do
  #   assert Apa.rem(~d"1", ~d"3") == d(1, 1, 0)
  #   assert Apa.rem(~d"42", ~d"2") == d(1, 0, 0)
  #   assert Apa.rem(~d"123", ~d"23") == d(1, 8, 0)
  #   assert Apa.rem(~d"123", ~d"-23") == d(1, 8, 0)
  #   assert Apa.rem(~d"-123", ~d"23") == d(-1, 8, 0)
  #   assert Apa.rem(~d"-123", ~d"-23") == d(-1, 8, 0)
  #   assert Apa.rem(~d"1", ~d"0.3") == d(1, 1, -1)
  #   assert Apa.rem(~d"4", ~d"8") == d(1, 4, 0)

  #   assert Apa.rem(~d"2.1", ~d"3") == d(1, 21, -1)
  #   assert Apa.rem(~d"10", ~d"3") == d(1, 1, 0)
  #   assert Apa.rem(~d"-10", ~d"3") == d(-1, 1, 0)
  #   assert Apa.rem(~d"10.2", ~d"1") == d(1, 2, -1)
  #   assert Apa.rem(~d"10", ~d"0.3") == d(1, 1, -1)
  #   assert Apa.rem(~d"3.6", ~d"1.3") == d(1, 10, -1)

  #   assert Apa.rem(~d"-inf", ~d"-2") == d(-1, 0, 0)
  #   assert Apa.rem(~d"5", ~d"-inf") == d(1, :inf, 0)
  #   assert Apa.rem(~d"nan", ~d"2") == d(1, :NaN, 0)

  #   assert_raise Error, fn ->
  #     Apa.rem(~d"inf", ~d"inf")
  #   end

  #   assert_raise Error, fn ->
  #     Apa.rem(~d"0", ~d"-0")
  #   end
  # end

  # test "max/2" do
  #   assert Apa.max(~d"0", ~d"0") == d(1, 0, 0)
  #   assert Apa.max(~d"1", ~d"0") == d(1, 1, 0)
  #   assert Apa.max(~d"0", ~d"1") == d(1, 1, 0)
  #   assert Apa.max(~d"-1", ~d"1") == d(1, 1, 0)
  #   assert Apa.max(~d"1", ~d"-1") == d(1, 1, 0)
  #   assert Apa.max(~d"-30", ~d"-40") == d(-1, 30, 0)

  #   assert Apa.max(~d"+0", ~d"-0") == d(1, 0, 0)
  #   assert Apa.max(~d"2e1", ~d"20") == d(1, 2, 1)
  #   assert Apa.max(~d"-2e1", ~d"-20") == d(-1, 20, 0)

  #   assert Apa.max(~d"-inf", ~d"5") == d(1, 5, 0)
  #   assert Apa.max(~d"inf", ~d"5") == d(1, :inf, 0)

  #   assert Apa.max(~d"nan", ~d"1") == d(1, 1, 0)
  #   assert Apa.max(~d"2", ~d"nan") == d(1, 2, 0)
  # end

  # test "min/2" do
  #   assert Apa.min(~d"0", ~d"0") == d(1, 0, 0)
  #   assert Apa.min(~d"-1", ~d"0") == d(-1, 1, 0)
  #   assert Apa.min(~d"0", ~d"-1") == d(-1, 1, 0)
  #   assert Apa.min(~d"-1", ~d"1") == d(-1, 1, 0)
  #   assert Apa.min(~d"1", ~d"0") == d(1, 0, 0)
  #   assert Apa.min(~d"-30", ~d"-40") == d(-1, 40, 0)

  #   assert Apa.min(~d"+0", ~d"-0") == d(-1, 0, 0)
  #   assert Apa.min(~d"2e1", ~d"20") == d(1, 20, 0)
  #   assert Apa.min(~d"-2e1", ~d"-20") == d(-1, 2, 1)

  #   assert Apa.min(~d"-inf", ~d"5") == d(-1, :inf, 0)
  #   assert Apa.min(~d"inf", ~d"5") == d(1, 5, 0)

  #   assert Apa.min(~d"nan", ~d"1") == d(1, 1, 0)
  #   assert Apa.min(~d"2", ~d"nan") == d(1, 2, 0)
  # end

  # test "negate/1" do
  #   assert Apa.negate(~d"0") == d(-1, 0, 0)
  #   assert Apa.negate(~d"1") == d(-1, 1, 0)
  #   assert Apa.negate(~d"-1") == d(1, 1, 0)

  #   assert Apa.negate(~d"inf") == d(-1, :inf, 0)
  #   assert Apa.negate(~d"nan") == d(1, :NaN, 0)
  # end

  # test "apply_context/1" do
  #   Context.with(%Context{precision: 2}, fn ->
  #     assert Apa.apply_context(~d"0") == d(1, 0, 0)
  #     assert Apa.apply_context(~d"5") == d(1, 5, 0)
  #     assert Apa.apply_context(~d"123") == d(1, 12, 1)
  #     assert Apa.apply_context(~d"nan") == d(1, :NaN, 0)
  #   end)
  # end

  # test "positive?/1" do
  #   Context.with(%Context{precision: 2}, fn ->
  #     refute Apa.positive?(~d"0")
  #     assert Apa.positive?(~d"5")
  #     refute Apa.positive?(~d"-5")
  #     assert Apa.positive?(~d"123.0")
  #     refute Apa.positive?(~d"nan")
  #   end)
  # end

  # test "negative?1" do
  #   Context.with(%Context{precision: 2}, fn ->
  #     refute Apa.negative?(~d"0")
  #     assert Apa.negative?(~d"-5")
  #     refute Apa.negative?(~d"5")
  #     assert Apa.negative?(~d"-123.0")
  #     refute Apa.negative?(~d"nan")
  #   end)
  # end

  test "mul/2" do
    assert Apa.mul("0", "0") == Apa.to_string({0, 0})
    assert Apa.mul("42", "0") == Apa.to_string({0, 0})
    assert Apa.mul("0", "42") == Apa.to_string({0, 0})
    assert Apa.mul("5", "5") == Apa.to_string({25, 0})
    assert Apa.mul("-5", "5") == Apa.to_string({-25, 0})
    assert Apa.mul("5", "-5") == Apa.to_string({-25, 0})
    assert Apa.mul("-5", "-5") == Apa.to_string({25, 0})
    assert Apa.mul("42", "0.42") == Apa.to_string({1764, -2})
    assert Apa.mul("0.03", "0.3") == Apa.to_string({9, -3})

    assert Apa.mul("0", "-0") == Apa.to_string({0, 0})
    assert Apa.mul("0", "3") == Apa.to_string({0, 0})
    assert Apa.mul("-0", "3") == Apa.to_string({0, 0})
    assert Apa.mul("0", "-3") == Apa.to_string({0, 0})

    # not supported with Apa at the moment
    # assert Apa.mult(~d"inf", ~d"-3") == d(-1, :inf, 0)
    # assert Apa.mult(~d"nan", ~d"2") == d(1, :NaN, 0)

    # assert_raise Error, fn ->
    #   Apa.mult(~d"inf", ~d"0")
    # end

    # assert_raise Error, fn ->
    #   Apa.mult(~d"0", ~d"-inf")
    # end
  end

  # test "normalize/1" do
  #   assert Apa.normalize(~d"2.1") == d(1, 21, -1)
  #   assert Apa.normalize(~d"2.10") == d(1, 21, -1)
  #   assert Apa.normalize(~d"-2") == d(-1, 2, 0)
  #   assert Apa.normalize(~d"-2.00") == d(-1, 2, 0)
  #   assert Apa.normalize(~d"200") == d(1, 2, 2)
  #   assert Apa.normalize(~d"0") == d(1, 0, 0)
  #   assert Apa.normalize(~d"-0") == d(-1, 0, 0)
  #   assert Apa.normalize(~d"-inf") == d(-1, :inf, 0)
  #   assert Apa.normalize(~d"nan") == d(1, :NaN, 0)
  # end

  test "to_string/2 normal" do
    assert Apa.to_string(Apa.new("0")) == "0"
    assert Apa.to_string(Apa.new("42")) == "42"
    assert Apa.to_string(Apa.new("42.42")) == "42.42"
    assert Apa.to_string(Apa.new("0.42")) == "0.42"
    assert Apa.to_string(Apa.new("0.0042")) == "0.0042"
    assert Apa.to_string(Apa.new("-1")) == "-1"
    assert Apa.to_string(Apa.new("-0")) == "0"
    assert Apa.to_string(Apa.new("-1.23")) == "-1.23"
    assert Apa.to_string(Apa.new("-0.0123")) == "-0.0123"
    # assert Apa.to_string(Apa.new("nan")) == "NaN"
    # assert Apa.to_string(Apa.new("-nan")) == "-NaN"
    # assert Apa.to_string(Apa.new("-inf")) == "-Infinity"
  end

  # test "to_string/2 scientific" do
  #   assert Apa.to_string(~d"123", :scientific) == "123"
  #   assert Apa.to_string(~d"-123", :scientific) == "-123"
  #   assert Apa.to_string(~d"123e1", :scientific) == "1.23E+3"
  #   assert Apa.to_string(~d"123e3", :scientific) == "1.23E+5"
  #   assert Apa.to_string(~d"123e-1", :scientific) == "12.3"
  #   assert Apa.to_string(~d"123e-5", :scientific) == "0.00123"
  #   assert Apa.to_string(~d"123e-10", :scientific) == "1.23E-8"
  #   assert Apa.to_string(~d"-123e-12", :scientific) == "-1.23E-10"
  #   assert Apa.to_string(~d"0", :scientific) == "0"
  #   assert Apa.to_string(~d"0e-2", :scientific) == "0.00"
  #   assert Apa.to_string(~d"0e2", :scientific) == "0E+2"
  #   assert Apa.to_string(~d"-0", :scientific) == "-0"
  #   assert Apa.to_string(~d"5e-6", :scientific) == "0.000005"
  #   assert Apa.to_string(~d"50e-7", :scientific) == "0.0000050"
  #   assert Apa.to_string(~d"5e-7", :scientific) == "5E-7"
  #   assert Apa.to_string(~d"4321.768", :scientific) == "4321.768"
  #   assert Apa.to_string(~d"-0", :scientific) == "-0"
  #   assert Apa.to_string(~d"nan", :scientific) == "NaN"
  #   assert Apa.to_string(~d"-nan", :scientific) == "-NaN"
  #   assert Apa.to_string(~d"-inf", :scientific) == "-Infinity"
  #   assert Apa.to_string(~d"84e-1", :scientific) == "8.4"
  #   assert Apa.to_string(~d"22E+2", :scientific) == "2.2E+3"
  # end

  # test "to_string/2 raw" do
  #   assert Apa.to_string(~d"2", :raw) == "2"
  #   assert Apa.to_string(~d"300", :raw) == "300"
  #   assert Apa.to_string(~d"4321.768", :raw) == "4321768E-3"
  #   assert Apa.to_string(~d"-53000", :raw) == "-53000"
  #   assert Apa.to_string(~d"0.0042", :raw) == "42E-4"
  #   assert Apa.to_string(~d"0.2", :raw) == "2E-1"
  #   assert Apa.to_string(~d"-0.0003", :raw) == "-3E-4"
  #   assert Apa.to_string(~d"-0", :raw) == "-0"
  #   assert Apa.to_string(~d"nan", :raw) == "NaN"
  #   assert Apa.to_string(~d"-nan", :raw) == "-NaN"
  #   assert Apa.to_string(~d"-inf", :raw) == "-Infinity"
  # end

  # test "to_string/2 xsd" do
  #   assert Apa.to_string(~d"0", :xsd) == "0.0"
  #   assert Apa.to_string(~d"0.0", :xsd) == "0.0"
  #   assert Apa.to_string(~d"0.001", :xsd) == "0.001"
  #   assert Apa.to_string(~d"-0", :xsd) == "-0.0"
  #   assert Apa.to_string(~d"-1", :xsd) == "-1.0"
  #   assert Apa.to_string(~d"-0.00", :xsd) == "-0.0"
  #   assert Apa.to_string(~d"1.00", :xsd) == "1.0"
  #   assert Apa.to_string(~d"1000", :xsd) == "1000.0"
  #   assert Apa.to_string(~d"1000.000000", :xsd) == "1000.0"
  #   assert Apa.to_string(~d"12345.000", :xsd) == "12345.0"
  #   assert Apa.to_string(~d"42", :xsd) == "42.0"
  #   assert Apa.to_string(~d"42.42", :xsd) == "42.42"
  #   assert Apa.to_string(~d"0.42", :xsd) == "0.42"
  #   assert Apa.to_string(~d"0.0042", :xsd) == "0.0042"
  #   assert Apa.to_string(~d"010.020", :xsd) == "10.02"
  #   assert Apa.to_string(~d"-1.23", :xsd) == "-1.23"
  #   assert Apa.to_string(~d"-0.0123", :xsd) == "-0.0123"
  #   assert Apa.to_string(~d"1E+2", :xsd) == "100.0"
  #   assert Apa.to_string(~d"-42E+3", :xsd) == "-42000.0"
  #   assert Apa.to_string(~d"nan", :xsd) == "NaN"
  #   assert Apa.to_string(~d"-nan", :xsd) == "-NaN"
  #   assert Apa.to_string(~d"-inf", :xsd) == "-Infinity"
  # end

  # test "to_integer/1" do
  #   Context.with(%Context{precision: 36, rounding: :floor}, fn ->
  #     assert Apa.to_integer(~d"0") == 0
  #     assert Apa.to_integer(~d"300") == 300
  #     assert Apa.to_integer(~d"-53000") == -53000
  #     assert Apa.to_integer(~d"-0") == 0
  #     assert Apa.to_integer(d(1, 10, 2)) == 1000
  #     assert Apa.to_integer(d(1, 1000, -2)) == 10
  #     assert Apa.to_integer(~d"123456789123489123456789") == 123_456_789_123_489_123_456_789

  #     assert Apa.to_integer(Apa.mult(~d"123456789123489123456789", ~d"1000")) ==
  #              123_456_789_123_489_123_456_789_000

  #     assert Apa.to_integer(d(1, 1_365_900_000_000_000_000_000, -2)) ==
  #              13_659_000_000_000_000_000

  #     assert_raise FunctionClauseError, fn ->
  #       Apa.to_integer(d(1, 1001, -2))
  #     end

  #     assert_raise FunctionClauseError, fn ->
  #       Apa.to_integer(d(1, :NaN, 0))
  #     end
  #   end)
  # end

  # test "to_float/1" do
  #   Context.with(%Context{precision: 36, rounding: :floor}, fn ->
  #     assert Apa.to_float(~d"0") === 0.0
  #     assert Apa.to_float(~d"-0") === 0.0
  #     assert Apa.to_float(~d"-0.0") === 0.0
  #     assert Apa.to_float(~d"3.00") === 3.00
  #     assert Apa.to_float(~d"-53.000") === -53.000
  #     assert Apa.to_float(~d"53000") === 53000.0
  #     assert Apa.to_float(~d"123.456") === 123.456
  #     assert Apa.to_float(~d"-123.456") === -123.456
  #     assert Apa.to_float(~d"123.45600") === 123.456
  #     assert Apa.to_float(~d"123456.789") === 123_456.789
  #     assert Apa.to_float(~d"123456789.123456789") === 123_456_789.12345679

  #     assert Apa.to_float(~d"94503599627370496") === 94_503_599_627_370_496.0
  #     assert Apa.to_float(~d"94503599627370496.376") === 94_503_599_627_370_496.376
  #     assert Apa.to_float(~d"4503599627370496") === 4_503_599_627_370_496.0
  #     assert Apa.to_float(~d"2251799813685248") === 2_251_799_813_685_248.0
  #     assert Apa.to_float(~d"9007199254740992") === 9_007_199_254_740_992.0

  #     assert_raise FunctionClauseError, fn ->
  #       Apa.to_float(d(1, :NaN, 0))
  #     end
  #   end)
  # end

  # test "round/3: special" do
  #   assert Apa.round(~d"inf", 2, :down) == d(1, :inf, 0)
  #   assert Apa.round(~d"nan", 2, :down) == d(1, :NaN, 0)
  # end

  # test "round/3: down" do
  #   round = &Apa.round(&1, 2, :down)
  #   roundneg = &Apa.round(&1, -2, :down)
  #   assert round.(~d"1.02") == d(1, 102, -2)
  #   assert round.(~d"1.029") == d(1, 102, -2)
  #   assert round.(~d"-1.029") == d(-1, 102, -2)
  #   assert round.(~d"102") == d(1, 10200, -2)
  #   assert round.(~d"0.001") == d(1, 0, -2)
  #   assert round.(~d"-0.001") == d(-1, 0, -2)
  #   assert roundneg.(~d"1.02") == d(1, 0, 2)
  #   assert roundneg.(~d"102") == d(1, 1, 2)
  #   assert roundneg.(~d"1099") == d(1, 10, 2)
  # end

  # test "round/3: ceiling" do
  #   round = &Apa.round(&1, 2, :ceiling)
  #   roundneg = &Apa.round(&1, -2, :ceiling)
  #   assert round.(~d"1.02") == d(1, 102, -2)
  #   assert round.(~d"1.021") == d(1, 103, -2)
  #   assert round.(~d"-1.021") == d(-1, 102, -2)
  #   assert round.(~d"102") == d(1, 10200, -2)
  #   assert roundneg.(~d"1.02") == d(1, 1, 2)
  #   assert roundneg.(~d"102") == d(1, 2, 2)
  # end

  # test "round/3: floor" do
  #   round = &Apa.round(&1, 2, :floor)
  #   roundneg = &Apa.round(&1, -2, :floor)
  #   assert round.(~d"1.02") == d(1, 102, -2)
  #   assert round.(~d"1.029") == d(1, 102, -2)
  #   assert round.(~d"-1.029") == d(-1, 103, -2)
  #   assert roundneg.(~d"123") == d(1, 1, 2)
  #   assert roundneg.(~d"-123") == d(-1, 2, 2)
  # end

  # test "round/3: half up" do
  #   round = &Apa.round(&1, 2, :half_up)
  #   roundneg = &Apa.round(&1, -2, :half_up)
  #   assert round.(~d"1.02") == d(1, 102, -2)
  #   assert round.(~d"1.025") == d(1, 103, -2)
  #   assert round.(~d"-1.02") == d(-1, 102, -2)
  #   assert round.(~d"-1.025") == d(-1, 103, -2)
  #   assert roundneg.(~d"120") == d(1, 1, 2)
  #   assert roundneg.(~d"150") == d(1, 2, 2)
  #   assert roundneg.(~d"-120") == d(-1, 1, 2)
  #   assert roundneg.(~d"-150") == d(-1, 2, 2)

  #   assert Apa.round(~d"243.48", 0, :half_up) == d(1, 243, 0)
  # end

  # test "round/3: half even" do
  #   round = &Apa.round(&1, 2, :half_even)
  #   roundneg = &Apa.round(&1, -2, :half_even)
  #   assert round.(~d"1.03") == d(1, 103, -2)
  #   assert round.(~d"1.035") == d(1, 104, -2)
  #   assert round.(~d"1.045") == d(1, 104, -2)
  #   assert round.(~d"-1.035") == d(-1, 104, -2)
  #   assert round.(~d"-1.045") == d(-1, 104, -2)
  #   assert roundneg.(~d"130") == d(1, 1, 2)
  #   assert roundneg.(~d"150") == d(1, 2, 2)
  #   assert roundneg.(~d"250") == d(1, 2, 2)
  #   assert roundneg.(~d"-150") == d(-1, 2, 2)
  #   assert roundneg.(~d"-250") == d(-1, 2, 2)

  #   assert Apa.round(~d"9.99", 0, :half_even) == d(1, 10, 0)
  #   assert Apa.round(~d"244.58", 0, :half_even) == d(1, 245, 0)
  # end

  # test "round/3: half down" do
  #   round = &Apa.round(&1, 2, :half_down)
  #   roundneg = &Apa.round(&1, -2, :half_down)
  #   assert round.(~d"1.02") == d(1, 102, -2)
  #   assert round.(~d"1.025") == d(1, 102, -2)
  #   assert round.(~d"-1.02") == d(-1, 102, -2)
  #   assert round.(~d"-1.025") == d(-1, 102, -2)
  #   assert roundneg.(~d"120") == d(1, 1, 2)
  #   assert roundneg.(~d"150") == d(1, 1, 2)
  #   assert roundneg.(~d"-120") == d(-1, 1, 2)
  #   assert roundneg.(~d"-150") == d(-1, 1, 2)
  # end

  # test "round/3: up" do
  #   round = &Apa.round(&1, 2, :up)
  #   roundneg = &Apa.round(&1, -2, :up)
  #   assert round.(~d"1.02") == d(1, 102, -2)
  #   assert round.(~d"1.029") == d(1, 103, -2)
  #   assert round.(~d"-1.029") == d(-1, 103, -2)
  #   assert round.(~d"102") == d(1, 10200, -2)
  #   assert round.(~d"0.001") == d(1, 1, -2)
  #   assert round.(~d"-0.001") == d(-1, 1, -2)
  #   assert roundneg.(~d"1.02") == d(1, 1, 2)
  #   assert roundneg.(~d"102") == d(1, 2, 2)
  #   assert roundneg.(~d"1099") == d(1, 11, 2)
  # end

  # test "sqrt/1" do
  #   Context.with(%Context{precision: 9, rounding: :half_even}, fn ->
  #     assert Apa.sqrt(~d"0") == d(1, 0, 0)
  #     assert Apa.sqrt(~d"-0") == d(-1, 0, 0)
  #     assert Apa.sqrt(~d"1") == d(1, 1, 0)
  #     assert Apa.sqrt(~d"1.0") == d(1, 10, -1)
  #     assert Apa.sqrt(~d"1.00") == d(1, 10, -1)
  #     assert Apa.sqrt(~d"0.01") == d(1, 1, -1)
  #     assert Apa.sqrt(~d"100") == d(1, 10, 0)
  #     assert Apa.sqrt(~d"10") == d(1, 316_227_766, -8)
  #     assert Apa.sqrt(~d"7") == d(1, 264_575_131, -8)
  #     assert Apa.sqrt(~d"0.39") == d(1, 624_499_800, -9)
  #   end)
  # end

  # test "issue #13" do
  #   round_down = &Apa.round(&1, 0, :down)
  #   round_up = &Apa.round(&1, 0, :up)
  #   assert round_down.(~d"-2.5") == d(-1, 2, 0)
  #   assert round_up.(~d"-2.5") == d(-1, 3, 0)
  #   assert round_up.(~d"2.5") == d(1, 3, 0)
  #   assert round_down.(~d"2.5") == d(1, 2, 0)
  # end

  # test "issue #35" do
  #   assert Apa.round(~d"0.0001", 0, :down) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0001", 0, :ceiling) == d(1, 1, 0)
  #   assert Apa.round(~d"0.0001", 0, :floor) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0001", 0, :half_up) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0001", 0, :half_even) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0001", 0, :half_down) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0001", 0, :up) == d(1, 1, 0)

  #   assert Apa.round(~d"0.0005", 0, :down) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0005", 0, :ceiling) == d(1, 1, 0)
  #   assert Apa.round(~d"0.0005", 0, :floor) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0005", 0, :half_up) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0005", 0, :half_even) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0005", 0, :half_down) == d(1, 0, 0)
  #   assert Apa.round(~d"0.0005", 0, :up) == d(1, 1, 0)
  # end

  # test "issue #29" do
  #   assert Apa.rem(~d"1.234", ~d"1") == d(1, 234, -3)
  #   assert Apa.rem(~d"1.234", ~d"1.0") == d(1, 234, -3)
  #   assert Apa.rem(~d"1.234", ~d"1.00") == d(1, 234, -3)
  # end

  test "issue #62" do
    assert Apa.from_float(0.0001) == {1, -4}
    assert Apa.from_float(0.00001) == {1, -5}
    assert Apa.from_float(0.000001) == {1, -6}
    assert Apa.from_float(-0.0001) == {-1, -4}
    assert Apa.from_float(-0.00001) == {-1, -5}
    assert Apa.from_float(-0.000001) == {-1, -6}
    assert Apa.from_float(0.00002) == {2, -5}
    assert Apa.from_float(0.00009) == {9, -5}
  end

  # test "issue #57" do
  #   assert Apa.round(~d"0.5", 0, :half_even) == d(1, 0, 0)
  #   assert Apa.round(~d"0.05", 1, :half_even) == d(1, 0, -1)
  #   assert Apa.round(~d"0.005", 2, :half_even) == d(1, 0, -2)
  #   assert Apa.round(~d"0.0005", 3, :half_even) == d(1, 0, -3)
  #   assert Apa.round(~d"0.00005", 4, :half_even) == d(1, 0, -4)
  #   assert Apa.round(~d"0.000005", 5, :half_even) == d(1, 0, -5)
  #   assert Apa.round(~d"0.0000005", 6, :half_even) == d(1, 0, -6)
  #   assert Apa.round(~d"-0.5", 0, :half_even) == d(-1, 0, 0)
  #   assert Apa.round(~d"-0.05", 1, :half_even) == d(-1, 0, -1)
  #   assert Apa.round(~d"-0.005", 2, :half_even) == d(-1, 0, -2)
  #   assert Apa.round(~d"-0.0005", 3, :half_even) == d(-1, 0, -3)
  #   assert Apa.round(~d"-0.00005", 4, :half_even) == d(-1, 0, -4)
  #   assert Apa.round(~d"-0.000005", 5, :half_even) == d(-1, 0, -5)
  #   assert Apa.round(~d"-0.0000005", 6, :half_even) == d(-1, 0, -6)
  #   assert Apa.round(~d"0.51", 0, :half_even) == d(1, 1, 0)
  #   assert Apa.round(~d"0.55", 1, :half_even) == d(1, 6, -1)
  #   assert Apa.round(~d"0.6", 0, :half_even) == d(1, 1, 0)
  #   assert Apa.round(~d"0.4", 0, :half_even) == d(1, 0, 0)
  # end

  # test "issue #60" do
  #   assert_raise(FunctionClauseError, "no function clause matching in Apa.Apa/1", fn ->
  #     Apa.round(nil)
  #   end)
  # end

  # test "issue #63" do
  #   round = &Apa.round(&1, 2, :half_down)
  #   roundneg = &Apa.round(&1, -2, :half_down)
  #   assert round.(~d"1.026") == d(1, 103, -2)
  #   assert round.(~d"1.0259") == d(1, 103, -2)
  #   assert round.(~d"-1.026") == d(-1, 103, -2)
  #   assert round.(~d"-1.0259") == d(-1, 103, -2)
  #   assert roundneg.(~d"155") == d(1, 2, 2)
  #   assert roundneg.(~d"160") == d(1, 2, 2)
  #   assert roundneg.(~d"-155") == d(-1, 2, 2)
  #   assert roundneg.(~d"-160") == d(-1, 2, 2)
  # end

  # test "issue #82" do
  #   to_float = fn binary -> Apa.new(binary) |> Apa.to_float() end
  #   assert to_float.("0.8888888888888888888888") == 0.8888888888888888888888
  #   assert to_float.("0.9999999999999999") == 0.9999999999999999
  #   assert to_float.("0.99999999999999999") == 0.99999999999999999
  # end
end
