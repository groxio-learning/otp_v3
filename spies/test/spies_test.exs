defmodule SpiesTest do
  use ExUnit.Case
  doctest Spies

  test "greets the world" do
    assert Spies.hello() == :world
  end
end
