defmodule BowlingTest do
  use ExUnit.Case
  doctest Bowling

  describe "rolls_to_frames/1" do
    test "12 rolls, 12 strikes, 10 frames + 2 bonus rolls (strike, strike)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      frames = ~w(X X X X X X X X X XXX)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 11 strikes, 10 frames + 2 bonus rolls (strike, miss)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0]
      frames = ~w(X X X X X X X X X XX-)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 11 strikes, 10 frames + 2 bonus rolls (strike, partial)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9]
      frames = ~w(X X X X X X X X X XX9)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 11 strikes, 10 frames + 2 bonus rolls (miss, spare)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0, 10]
      frames = ~w(X X X X X X X X X X-/)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 10 strikes, 10 frames + 2 bonus rolls (miss, miss)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0, 0]
      frames = ~w(X X X X X X X X X X--)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 10 strikes, 10 frames + 2 bonus rolls (miss, partial)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0, 9]
      frames = ~w(X X X X X X X X X X-9)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 11 strikes, 10 frames + 2 bonus rolls (partial, spare)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 1]
      frames = ~w(X X X X X X X X X X9/)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 10 strikes, 10 frames + 2 bonus rolls (partial, miss)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 0]
      frames = ~w(X X X X X X X X X X9-)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 10 strikes, 10 frames + 2 bonus rolls (partial, partial)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9]
      frames = ~w(X X X X X X X X X X99)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 9 initial strikes, 1 spare, 10 frames + 1 bonus roll (strike)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 1, 10]
      frames = ~w(X X X X X X X X X 9/X)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 9 initial strikes, 1 spare, 10 frames + 1 bonus roll (miss)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 9, 0]
      frames = ~w(X X X X X X X X X 1/-)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "12 rolls, 9 initial strikes, 1 spare, 10 frames + 1 bonus roll (partial)" do
      rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 5, 5, 9]
      frames = ~w(X X X X X X X X X 5/9)
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

    test "20 rolls: 9 pairs of initial spares, with no last strike or spare" do
      rolls = [1, 9, 2, 8, 3, 7, 4, 6, 5, 5, 6, 4, 7, 3, 8, 2, 9, 1, 0, 0]
      frames = ~w(1/ 2/ 3/ 4/ 5/ 6/ 7/ 8/ 9/ --)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "20 rolls: 9 pairs of initial spares consisting of misses, with no final strike" do
      rolls = [0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0]
      frames = ~w(-/ -/ -/ -/ -/ -/ -/ -/ -/ --)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "21 rolls: spare consisting of a miss in the 10th frame, + 1 bonus (strike)" do
      rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
      frames = ~w(-- -- -- -- -- -- -- -- -- -/X)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "21 rolls: spare consisting of a miss in the 10th frame, + 1 bonus (miss)" do
      rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0]
      frames = ~w(-- -- -- -- -- -- -- -- -- -/-)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "21 rolls: spare consisting of a miss in the 10th frame, + 1 bonus (partial)" do
      rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 9]
      frames = ~w(-- -- -- -- -- -- -- -- -- -/9)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "21 rolls: spare (without a miss in that frame) in the 10th frame, + 1 bonus (strike)" do
      rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 10]
      frames = ~w(-- -- -- -- -- -- -- -- -- 5/X)
      assert Bowling.rolls_to_frames(rolls) == frames
    end

    test "doesn't pair combine frames across frames" do
      rolls = [0, 9, 1, 8, 2, 7, 3, 6, 4, 5, 5, 4, 3, 0, 0, 5, 5, 1, 9, 0]
      frames = ~w(-9 18 27 36 45 54 3- -5 51 9-)
      assert Bowling.rolls_to_frames(rolls) == frames
    end
  end

  describe "score/1" do
    test "(12 rolls: 12 strikes) = 10 frames * 30 points = 300" do
      frames = ~w(X X X X X X X X X XXX)
      assert Bowling.score(frames) == 300
    end

    test "(20 rolls: 10 pairs of 9 and miss) = 10 frames * 9 points = 90" do
      frames = ~w(9- 9- 9- 9- 9- 9- 9- 9- 9- 9-)
      assert Bowling.score(frames) == 90
    end

    test "(21 rolls: 10 pairs of 5 and spare, with a final 5) = 10 frames * 15 points = 150" do
      frames = ~w(5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5)
      assert Bowling.score(frames) == 150
    end

    test "a game with all zeros" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 0
    end

    test "a game with no strikes or spares" do
      actual_frames =
        [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 90
    end

    test "a spare followed by zeros is worth ten points" do
      actual_frames =
        [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 10
    end

    test "points scored in the roll after a spare are counted twice" do
      actual_frames =
        [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 16
    end

    test "consecutive spares each get a one roll bonus" do
      actual_frames =
        [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 31
    end

    test "a spare in the last frame gets a one roll bonus that is counted once" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 17
    end

    test "a strike earns ten points in a frame with a single roll" do
      actual_frames =
        [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 10
    end

    test "points scored in the two rolls after a strike are counted twice as a bonus" do
      actual_frames =
        [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 26
    end

    test "points scored in a spare rolled after a strike is counted as a bonus" do
      actual_frames =
        [10, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 30
    end

    test "consecutive strikes each get the two roll bonus" do
      actual_frames =
        [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 81
    end

    test "a strike in the last frame gets a two roll bonus that is counted once" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 18
    end

    test "rolling a spare with the two roll bonus does not get a bonus roll" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 20
    end

    test "strikes with the two roll bonus do not get bonus rolls" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 30
    end

    test "strike in the 10th frame, followed by a non strike and a spare" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 20
    end

    test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 20
    end

    test "a spare in the 9th frame with strikes afterwards" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 10, 10, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 50
    end

    test "a spare surrounded by strikes" do
      actual_frames =
        [10, 5, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 50
    end

    test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 26
    end

    test "spare in the 10th frame, surrounded by strikes" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5, 5, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 40
    end

    test "strikes in frame 8, 9 and 10" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 0, 0]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 60
    end

    test "strike in frame 10, with a miss spare in the bonus" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 20
    end

    test "strikes in frame 9 and 10, with a spare in the bonus" do
      actual_frames =
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 5, 5]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 45
    end

    test "a perfect game" do
      actual_frames =
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
        |> Bowling.rolls_to_frames()
        |> Bowling.score()

      assert actual_frames == 300
    end
  end
end
