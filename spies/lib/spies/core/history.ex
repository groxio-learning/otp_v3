defmodule Spies.Core.History do
  defstruct [answer: [1,2,3,4], guesses: []]

  def new(opts, size \\ 4)
  def new({:repeat, :random}, size) do
    %__MODULE__{answer: generate_random_list_with_repeats(size)}
  end

  def new({:random}, size) do
    %__MODULE__{answer: generate_random_list_no_repeats(size)}
  end

  def new({}, answer) do
    %__MODULE__{answer: answer}
  end

  defp generate_random_list_no_repeats(size) do
    Enum.take_random(1..8, size)
  end

  defp generate_random_list_with_repeats(size) do
    Stream.repeatedly(fn -> Enum.random(1..8) end)
    |> Enum.take(size)
  end

  def guess(game, current_guess) do
    %{game | guesses: [current_guess | game.guesses]}
  end

end
