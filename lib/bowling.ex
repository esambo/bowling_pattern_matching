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
  defp num("-"), do: 0
  defp num(d), do: String.to_integer(d)

  @doc """
  Total score of the game at the end.
  """
  def score(_frames) do
  end
end
