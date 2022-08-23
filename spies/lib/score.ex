defmodule Spies.Score do
  # TODO Handle multiple colors in the same guess better
  def accumulator() do
    %{red: 0, white: 0}
  end

  def increment_color(accumulator, color) do
    {_, new_accumulator} =
      Map.get_and_update(accumulator, color, fn value -> {value, value + 1} end)

    new_accumulator
  end

  def check_score(answer, guess) do
    # answer/guess look like [4, 2, 1, 8]
    result = accumulator()

    # reduce across the guess, comparing and incrementing at each location
    guess
    |> Enum.with_index()
    |> Enum.reduce(result, fn {guess_item, index}, result_acc ->
      cond do
        guess_item == Enum.at(answer, index) -> increment_color(result_acc, :red)
        Enum.member?(answer, guess_item) -> increment_color(result_acc, :white)
        true -> result_acc
      end
    end)

    # ${red: 0, white: 1}
  end

  def convert(rw_map) do
    # takes %{red: 0, white: 1}, return "RRW" if red = 2, white = 1
    String.duplicate("R", Map.get(rw_map, :red)) <> String.duplicate("W", Map.get(rw_map, :white))
  end
end
