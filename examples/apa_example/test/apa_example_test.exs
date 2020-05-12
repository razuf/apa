defmodule ApaExampleTest do
  use ExUnit.Case
  import Apa
  import Kernel, except: [+: 2, -: 2, *: 2, /: 2, to_string: 1, abs: 1]
  doctest ApaExample

  test "the answer" do
    assert ApaExample.the_answer() == "42"
  end

  test "add test" do
    assert Apa.add("1", "2") == "3"
  end

  test "sub test" do
    assert Apa.sub("3", "2") == "1"
  end

  test "mul test" do
    assert Apa.mul("3", "2") == "6"
  end

  test "div test" do
    assert Apa.div("6", "2") == "3"
  end

  test "some special apa tests" do
    assert "46.83" == Apa.add("1.23", "45.6")
    assert "45600000012.4" == Apa.add("12.3", "45600000000.1")
    assert "0.123456000000001" == Apa.add("0.123", "0.000456000000001")
    assert "0.123456000000001" == Apa.add("0.000456000000001", "0.123")
    assert "579" == "123" + "456"
    assert "123000000000000000000456" == "123000000000000000000000" + "456"
    assert "4560000000000000000123" == "123" + "4560000000000000000000"
    assert "0.00000000000000001" == "3.30000000000000004" - "3.30000000000000003"
    assert "6.71111111111111107" == "3.31111111111111114" + "3.39999999999999993"
    assert "579" == Integer.to_string(123 + 456)
    assert "690" == Integer.to_string(123 + 456) + "111"
    assert "12300" == Apa.to_string({123, 2})
    assert "456000" == Apa.to_string({456, 3})
    assert "45600" == Apa.to_string({456, 2})
    assert {579, 2} == {123, 2} + {456, 2}
    assert "456001.23" == "1.23" + "456e3"
    assert "456001.23" == "1.23" + "456.0e+003"

    assert "132342342342300000000455987.88" ==
             "132342342342300000000000000" + "456e3" - "0012.1200"

    assert "48.884" == "2.2" * "22.22"
    assert "4444444444.4444444444444" == "0.00000000002" * "222222222222222222222.22"
    assert "-48.884" == "0002.20000000" * "-00022.22000000"
    assert "222.2001" == "0.1" * "2222.001"

    assert "10" == "2222.001" / "222.2001"

    assert "4.803996494145874505235775" ==
             "17.123" / "3.564324"

    price = "3.51 Euro"
    quantity = "12"
    total_string = price * quantity
    assert total_string == "42.12"
  end
end
