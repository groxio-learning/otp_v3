defmodule Core.IntTest do
  use ExUnit.Case

  alias Chocula.Core.Int

  test "two steps forward, one step back" do
    assert Int.new("42") |> Int.increment() |> Int.increment() |> Int.decrement() == 43
  end
end
  
