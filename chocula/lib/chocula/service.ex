defmodule Chocula.Service do
  alias Chocula.Core.Map, as: Counter

  def listen(count) do
    receive do
      :increment ->
        new_count = Counter.accumulate(count, 1)
        new_count

      :decrement ->
        new_count = Counter.accumulate(count, -1)
        new_count

      {:display, from} ->
        new_count = count
        message = Counter.display(new_count)

        send(from, message)
        new_count
    end
  end

  def loop(count) do
    count
    |> listen()
    |> loop()
  end

  def start(input) do
    initial_value = Counter.construct(input)

    spawn(fn -> loop(initial_value) end)
  end
end
