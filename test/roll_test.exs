defmodule RollTest do
  use ExUnit.Case
  doctest Roll

  test "greets the world" do
    assert Roll.hello() == :world
  end
end
