defmodule ApaTest do
  use ExUnit.Case
  doctest Apa

  test "greets the world" do
    assert Apa.hello() == :world
  end
end
