defmodule BowlingTest do
  use ExUnit.Case
  doctest Bowling

  describe "rolls_to_frames/1" do
    test "12 rolls, 12 strikes, 10 + 2 frames" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      frames = ~w(X X X X X X X X X X X X)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "20 rolls, 10 frames of never striking, sparing or missing" do
      rolls = [1, 1, 2, 2, 3, 3, 4, 4, 5, 4, 6, 3, 7, 2, 8, 1, 2, 3, 4, 5]
      frames = ~w(11 22 33 44 54 63 72 81 23 45)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "20 rolls, with misses, but no spares or strikes ever, 10 frames" do
      rolls = [0, 0, 0, 1, 0, 9, 9, 0, 1, 0, 0, 2, 3, 0, 0, 4, 5, 0, 0, 6]
      frames = ~w(-- -1 -9 9- 1- -2 3- -4 5- -6)
      assert Bowling.rolls_to_frames(rolls) == frames
    end
  end

  describe "score/1" do
    test "(12 rolls: 12 strikes) = 10 frames * 30 points = 300" do
      frames = ~w(X X X X X X X X X X X X)
      assert Bowling.score(frames) == 300
    end

    @tag :skip
    test "(20 rolls: 10 pairs of 9 and miss) = 10 frames * 9 points = 90" do
      frames = ~w(9- 9- 9- 9- 9- 9- 9- 9- 9- 9-)
      assert Bowling.score(frames) == 90
    end

    @tag :skip
    test "(21 rolls: 10 pairs of 5 and spare, with a final 5) = 10 frames * 15 points = 150" do
      frames = ~w(5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5)
      assert Bowling.score(frames) == 150
    end

    @tag :skip
    test "a game with all zeros" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 0
    end

    @tag :skip
    test "a game with no strikes or spares" do
      rolls  = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 90
    end

    @tag :skip
    test "a spare followed by zeros is worth ten points" do
      rolls  = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 10
    end

    @tag :skip
    test "points scored in the roll after a spare are counted twice" do
      rolls  = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 16
    end

    @tag :skip
    test "consecutive spares each get a one roll bonus" do
      rolls  = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 31
    end

    @tag :skip
    test "a spare in the last frame gets a one roll bonus that is counted once" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 17
    end

    @tag :skip
    test "a strike earns ten points in a frame with a single roll" do
      rolls  = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 10
    end

    @tag :skip
    test "points scored in the two rolls after a strike are counted twice as a bonus" do
      rolls  = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 26
    end

    @tag :skip
    test "consecutive strikes each get the two roll bonus" do
      rolls  = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 81
    end

    @tag :skip
    test "a strike in the last frame gets a two roll bonus that is counted once" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 18
    end

    @tag :skip
    test "rolling a spare with the two roll bonus does not get a bonus roll" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 20
    end

    @tag :skip
    test "strikes with the two roll bonus do not get bonus rolls" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 30
    end

    @tag :skip
    test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 20
    end

    @tag :skip
    test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" do
      rolls  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
      frames = Bowling.rolls_to_frames(rolls)
      assert Bowling.score(frames) == 26
    end
  end
end
