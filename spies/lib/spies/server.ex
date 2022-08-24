defmodule Spies.Server do
  use GenServer
  alias Spies.Core.Game

  @impl true
  def init(_) do
    IO.puts("Initializing Spies...")
    {:ok, Game.new(%{random: true, size: 4})}
  end

  def child_spec(name) do
    %{id: name, start: {Spies.Server, :start_link, [name]}}
  end

  @impl true
  def handle_call({:guess, guess}, _from, current_game) do
    next_game = Game.guess(current_game, guess)
    {:reply, Game.show(next_game), next_game}
  end

  # client API
  def start_link(name \\ :spies) do
    IO.puts("Starting Spies GenServer for #{name}...")
    GenServer.start_link(__MODULE__, :unused, name: name)
  end

  def guess(name, guess) do
    # validate guess
    name
    |> GenServer.call({:guess, guess})
    |> IO.puts()
  end

end
