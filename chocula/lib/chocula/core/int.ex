defmodule Chocula.Core.Int do
  @moduledoc false

  def new(to_count) do
    to_count
    |> String.to_integer()
  end

  def increment(value) do
    value + 1
  end

  def decrement(value) do
    value - 1
  end

  def display(value) do
    "#{value}! #{value} items! Ah Ah Ah!"
  end
end
