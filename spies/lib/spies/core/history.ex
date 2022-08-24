defmodule Spies.Core.History do
  defstruct [answer: [1,2,3,4], guesses: [], status: :playing]

  alias Spies.Score

  @n_turns 10

  @spec new({} | {:random} | {:repeat, :random}, any) :: %Spies.Core.History{
          answer: any,
          guesses: []
        }
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
    %{game | guesses: [current_guess | game.guesses], status: get_status(game, current_guess)}
  end

  defp get_status(game, current_guess) when current_guess == game.answer do
    :winner
  end
  defp get_status(game, _) when length(game.guesses) + 1 == @n_turns do
    :loser
  end
  defp get_status(_, _) do
    :playing
  end

  def converter(%{guesses: [current_guess | _], answer: answer}) do
    Score.check(answer, current_guess)
  end

end
