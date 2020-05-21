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

  defp do_rolls_to_frames([10, 10, 10], frames) do
    ["XXX" | frames]
  end

  defp do_rolls_to_frames([10, 10, 0], frames) do
    ["XX-" | frames]
  end

  defp do_rolls_to_frames([10 | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["X" | frames])
  end

  defp do_rolls_to_frames([0, 0 | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["--" | frames])
  end

  defp do_rolls_to_frames([0, second_roll | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["-#{second_roll}" | frames])
  end

  defp do_rolls_to_frames([first_roll, 0 | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["#{first_roll}-" | frames])
  end

  defp do_rolls_to_frames([first_roll, second_roll | remaining_rolls], frames) do
    do_rolls_to_frames(remaining_rolls, ["#{first_roll}#{second_roll}" | frames])
  end

  @doc """
  Total score of the game at the end.
  """
  def score(_frames) do
  end
end
