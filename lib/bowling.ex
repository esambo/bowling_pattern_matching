defmodule Bowling do
  @moduledoc """
  Score a bowling game.
  """

  @doc """
  Groups a list of rolls (0-10) by frame.
  Converts:
  - 10 into "X" to indicate a strike
  - 10 into "/" to indicate a spare
  -  0 into "-" to indicate a miss
  """
  def rolls_to_frames(rolls) do
    rolls
    |> do_rolls_to_frames([])
    |> Enum.reverse()
  end

  defp do_rolls_to_frames([], frames) do
    frames
  end

  defp do_rolls_to_frames([10 = _frame_10_strike, bonus_1, bonus_2], frames)
       when bonus_1 + bonus_2 == 10 and bonus_1 != 10 do
    ["X#{sym(bonus_1)}/" | frames]
  end

  defp do_rolls_to_frames([10 = _frame_10_strike, bonus_1, bonus_2], frames) do
    ["X#{sym(bonus_1)}#{sym(bonus_2)}" | frames]
  end

  defp do_rolls_to_frames([frame_10_try_1, frame_10_try_2, bonus_1], frames)
       when frame_10_try_1 + frame_10_try_2 == 10 do
    ["#{sym(frame_10_try_1)}/#{sym(bonus_1)}" | frames]
  end

  defp do_rolls_to_frames([10 = _strike | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["X" | frames])
  end

  defp do_rolls_to_frames([try_1, try_2 | remaining_rolls], frames)
       when try_1 + try_2 == 10 do
    do_rolls_to_frames(remaining_rolls, ["#{sym(try_1)}/" | frames])
  end

  defp do_rolls_to_frames([try_1, try_2 | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["#{sym(try_1)}#{sym(try_2)}" | frames])
  end

  # Converts a number into a symbol.
  defp sym(10), do: "X"
  defp sym(0), do: "-"
  defp sym(d), do: "#{d}"

  # Converts a symbol into a number.
  defp num("X"), do: 10
  defp num("9"), do: 9
  defp num("8"), do: 8
  defp num("7"), do: 7
  defp num("6"), do: 6
  defp num("5"), do: 5
  defp num("4"), do: 4
  defp num("3"), do: 3
  defp num("2"), do: 2
  defp num("1"), do: 1
  defp num("-"), do: 0

  @doc """
  Total score of the game at the end.
  """
  def score(frames) do
    do_score(frames, 0)
  end

  defp do_score(
         [
           "X",
           "X",
           "X"
           | remaining_frames
         ],
         score
       ) do
    do_score(["X", "X" | remaining_frames], score + 10 + 10 + 10)
  end

  defp do_score(
         [
           "X",
           "X",
           <<next_1::binary-size(1), _::binary>> = frame_peek_2
           | remaining_frames
         ],
         score
       ) do
    do_score(["X", frame_peek_2 | remaining_frames], score + 10 + 10 + num(next_1))
  end

  defp do_score(
         [
           "X",
           <<_next_1::binary-size(1), "/">> = frame_peek_1
           | remaining_frames
         ],
         score
       ) do
    do_score([frame_peek_1 | remaining_frames], score + 10 + 10)
  end

  defp do_score(
         [
           "X",
           <<next_1::binary-size(1), next_2::binary-size(1)>> = frame_peek_1
           | remaining_frames
         ],
         score
       ) do
    do_score([frame_peek_1 | remaining_frames], score + 10 + num(next_1) + num(next_2))
  end

  defp do_score(
         [
           <<_try_1::binary-size(1), "/">>,
           <<next_1::binary-size(1), _::binary>> = frame_peek_1
           | remaining_frames
         ],
         score
       ) do
    do_score([frame_peek_1 | remaining_frames], score + 10 + num(next_1))
  end

  defp do_score(
         [
           <<try_1::binary-size(1), try_2::binary-size(1)>>
           | remaining_frames
         ],
         score
       ) do
    do_score(remaining_frames, score + num(try_1) + num(try_2))
  end

  defp do_score(
         [
           "X",
           <<_try_1::binary-size(1), "/", _bonus_1::binary>> = frame_10_peek
         ],
         score
       ) do
    do_score([frame_10_peek], score + 10 + 10)
  end

  defp do_score(
         [
           "X",
           <<"X", bonus_1::binary-size(1), _bonus_2::binary-size(1)>> = frame_10_peek
         ],
         score
       ) do
    do_score([frame_10_peek], score + 10 + 10 + num(bonus_1))
  end

  defp do_score(
         [
           <<_frame_10_try_1::binary-size(1), "/", bonus_1::binary-size(1)>>
         ],
         score
       ) do
    score + 10 + num(bonus_1)
  end

  defp do_score(
         [
           <<"X", _bonus_1::binary-size(1), "/">>
         ],
         score
       ) do
    score + 10 + 10
  end

  defp do_score(
         [
           <<"X", bonus_1::binary-size(1), bonus_2::binary-size(1)>>
         ],
         score
       ) do
    score + 10 + num(bonus_1) + num(bonus_2)
  end

  defp do_score(
         [],
         score
       ) do
    score
  end
end
