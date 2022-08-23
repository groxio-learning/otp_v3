defmodule Spies.Score do
  # TODO Handle multiple colors in the same guess better
  def accumulator() do
    %{red: 0, white: 0, red_colors: []}
  end

  def increment_red(accumulator, guess_value) do
    {_, new_accumulator} =
      Map.get_and_update(accumulator, :red, fn value -> {value, value + 1} end)

    {_, new_accumulator} =
      Map.get_and_update(new_accumulator, :red_colors, fn red_color_list ->
        {red_color_list, red_color_list ++ [guess_value]}
      end)

    new_accumulator
  end

  def increment_white(accumulator) do
    {_, new_accumulator} =
      Map.get_and_update(accumulator, :white, fn value -> {value, value + 1} end)

    new_accumulator
  end

  def find_reds(acc, answer, guess) do
    guess
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {guess_item, index}, result_acc ->
      cond do
        guess_item == Enum.at(answer, index) -> increment_red(result_acc, guess_item)
        true -> result_acc
      end
    end)
  end

  def find_whites(acc, answer, guess) do
    guess
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {guess_item, index}, result_acc ->
      cond do
        Enum.member?(answer, guess_item) and
            not Enum.member?(Map.get(acc, :red_colors), guess_item) ->
          increment_white(result_acc)

        true ->
          result_acc
      end
    end)
  end

  def check_score(answer, guess) do
    # answer/guess look like [4, 2, 1, 8] ${red: 0, white: 1}
    accumulator()
    |> find_reds(answer, guess)
    |> find_whites(answer, guess)
  end

  def convert(rw_map) do
    # takes %{red: 0, white: 1}, return "RRW" if red = 2, white = 1
    String.duplicate("R", Map.get(rw_map, :red)) <> String.duplicate("W", Map.get(rw_map, :white))
  end
end
