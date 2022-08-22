defmodule Chocula.Core.Map do
  @moduledoc """
  Documentation for `Chocula`.
  """
  def construct(input), do: %{count: String.to_integer(input)}

  def accumulate(%{count: count}, increment), do: %{count: count + increment}

  def display(%{count: count}), do: "The count is #{count}"
end
