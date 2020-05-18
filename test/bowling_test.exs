defmodule BowlingTest do
  use ExUnit.Case
  doctest Bowling

  test "greets the world" do
    assert Bowling.hello() == :world
  end
end
