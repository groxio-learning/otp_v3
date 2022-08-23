defmodule Spies.Score do
  defstruct [:reds, :whites]

  def new(answer, guess) do
    reds = count_reds(answer, guess)
    whites = length(answer) - reds - count_misses(answer, guess)

    %__MODULE__{
      reds: reds,
      whites: whites
    }
  end

  defp count_reds(answer, guess) do
    answer
    |> Enum.zip(guess)
    |> Enum.count(fn
      {x, x} -> true
      _ -> false
    end)
  end

  defp count_misses(answer, guess) do
    Enum.count(guess -- answer)
  end

  def convert(score) do
    String.duplicate("R", score.reds) <> String.duplicate("W", score.whites)
  end

  def check(answer, guess) do
    answer
    |> new(guess)
    |> convert()
  end
end
