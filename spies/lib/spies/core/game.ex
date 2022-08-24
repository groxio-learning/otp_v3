defmodule Spies.Core.Game do
  defstruct [answer: [1,2,3,4], guesses: [], status: :playing]

  alias Spies.Score

  @n_turns 10

  def new(%{answer: answer}) do
    %__MODULE__{answer: answer}
  end

  def new(args = %{repeat: true, random: true}) do
    %__MODULE__{answer: generate_random_list_with_repeats(Map.get(args, :size, 4))}
  end

  def new(args) do
    %__MODULE__{answer: generate_random_list_no_repeats(Map.get(args, :size, 4))}
  end

  defp generate_random_list_no_repeats(size) do
    Enum.take_random(1..8, size)
  end

  defp generate_random_list_with_repeats(size) do
    Stream.repeatedly(fn -> Enum.random(1..8) end)
    |> Enum.take(size)
  end

  def guess(game, current_guess) do
    next_game = %{game | guesses: [current_guess | game.guesses]}
    %{next_game | status: get_status(game)}
  end

  defp get_status(%{answer: answer, guesses: [answer | _guesses]}) do
    :winner
  end
  defp get_status(game) when length(game.guesses) == @n_turns do
    :loser
  end
  defp get_status(_game) do
    :playing
  end

  def show(game) do
    """
    #{show_answer(game)}

    #{rows(game)}
    #{get_status(game)}
    """
  end

  defp rows(game) do
    game.guesses
    |> Enum.map(&row(game.answer, &1))
    |> Enum.join("\n")
  end

  defp row(answer, guess) do
    "#{inspect(guess)} | #{Score.check(answer, guess)}"
  end

  defp show_answer(%{status: :playing} = game) do
    String.duplicate("? ", length(game.answer))
  end

  defp show_answer(game) do
    inspect(game.answer)
  end
end
