defmodule ChoculaTest do
  use ExUnit.Case
  doctest Chocula

  alias Chocula.Core.Map

  test "make map increment from count" do
    assert Map.construct("42") |> Map.accumulate(2) |> Map.display() == "The count is 44"
  end

  test "make map decrement from count" do
    assert Map.construct("42") |> Map.accumulate(-2) |> Map.display() == "The count is 40"
  end
end
