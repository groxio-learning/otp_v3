defmodule Spies.Server do
  use GenServer
  alias Spies.Core.History, as: Game

  @impl true
  def init(_) do
    {:ok, Game.new({:random}, 4)}
  end

  @impl true
  def handle_call({:guess, guess}, _from, current_game) do
    next_game = Game.guess(current_game, guess)
    {:reply, Game.show(next_game), next_game}
  end

  # client API
  def start_link(name \\ :spies) do
    GenServer.start_link(__MODULE__, :unused, name: name)
  end

  def guess(name, guess) do
    # validate guess
    name
    |> GenServer.call({:guess, guess})
    |> IO.puts()
  end

end
