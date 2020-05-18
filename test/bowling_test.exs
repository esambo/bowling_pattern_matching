defmodule BowlingTest do
  use ExUnit.Case
  doctest Bowling

  describe "score/1" do
    test "(12 rolls: 12 strikes) = 10 frames * 30 points = 300" do
      frames = ~w(X X X X X X X X X X X X)
      assert Bowling.score(frames) == 300
    end

    @tag :pending
    test "(20 rolls: 10 pairs of 9 and miss) = 10 frames * 9 points = 90" do
      frames = ~w(9- 9- 9- 9- 9- 9- 9- 9- 9- 9-)
      assert Bowling.score(frames) == 90
    end

    @tag :pending
    test "(21 rolls: 10 pairs of 5 and spare, with a final 5) = 10 frames * 15 points = 150" do
      frames = ~w(5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5)
      assert Bowling.score(frames) == 150
    end
  end
end
