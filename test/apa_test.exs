defmodule ApaTest do
  use ExUnit.Case
  doctest Apa
  doctest ApaNumber

  @moduledoc """
  Documentation for `ApaTest`.
  """

  test "wrong input" do
    assert_raise ArgumentError, fn -> Apa.add(1, 2) end
  end

  test "add test" do
    assert Apa.add("1", "2") == "3"
  end

  test "sub test" do
    assert Apa.sub("3", "2") == "1"
  end
end
