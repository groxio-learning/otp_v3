defmodule Spies.Core.History do

  def new(opts, size \\ 4)
  def new({:repeat, :random}, size) do
    %{}
    |> Map.put(:guesses, [])
    |> Map.put(:answer, generate_random_list_with_repeats(size))
  end

  def new({:random}, size) do
    %{}
    |> Map.put(:guesses, [])
    |> Map.put(:answer, generate_random_list_no_repeats(size))
  end

  def new({}, answer) do
    %{}
    |> Map.put(:guesses, [])
    |> Map.put(:answer, answer)
  end

  defp generate_random_list_no_repeats(size) do
    Enum.take_random(0..9, size)
  end

  defp generate_random_list_with_repeats(size) do
    Enum.reduce(1..size, [], fn _, acc -> acc ++ [Enum.random(0..9)] end)
  end

  def guess(state, current_guess) do
    state
    |> Map.put(:guesses, [current_guess | state.guesses])
  end

end
