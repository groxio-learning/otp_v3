defmodule Chocula.Server do
  use GenServer
  alias Chocula.Core.Map, as: Counter

  @impl true
  def init(counter) do
    {:ok, Counter.construct(counter)}
  end

  @impl true
  def handle_call(:display, _from, state) do
    {:reply, Counter.display(state), state}
  end

  @impl true
  def handle_cast(:increment, state) do
    {:noreply, Counter.accumulate(state, 1)}
  end

  @impl true
  def handle_cast(:decrement, state) do
    {:noreply, Counter.accumulate(state, -1)}
  end

  def start_link(name) do
    GenServer.start_link(__MODULE__, "42", name: name)
  end

  def increment(counter \\ :counter) do
    GenServer.cast(counter, :increment)
  end

  def decrement(counter \\ :counter) do
    GenServer.cast(counter, :decrement)
  end

  def display(counter \\ :counter) do
    GenServer.call(counter, :display)
  end

end
