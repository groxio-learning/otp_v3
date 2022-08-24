defmodule GameTest do
  use ExUnit.Case
  alias Spies.Core.Game

  doctest Game

  test "random new test" do
    result = Game.new(%{random: true})

    assert Map.has_key?(result, :guesses)
    assert Map.has_key?(result, :answer)
    assert length(result.answer) == 4
    assert length(result.guesses) == 0
  end

  test "random new test with size" do
    result = Game.new(%{random: true, size: 6})

    assert Map.has_key?(result, :guesses)
    assert Map.has_key?(result, :answer)
    assert length(result.answer) == 6
    assert length(result.guesses) == 0
  end

  test "random new test with size and repeats" do
    result = Game.new(%{repeat: true, random: true, size: 6})

    assert Map.has_key?(result, :guesses)
    assert Map.has_key?(result, :answer)
    assert length(result.answer) == 6
    assert length(result.guesses) == 0
  end

  test "random new test with repeats" do
    result = Game.new(%{repeat: true, random: true})

    assert Map.has_key?(result, :guesses)
    assert Map.has_key?(result, :answer)
    assert length(result.answer) == 4
    assert length(result.guesses) == 0
  end

  test "provided new test" do
    result = Game.new(%{answer: [1,2,3,4]})

    assert Map.has_key?(result, :guesses)
    assert Map.has_key?(result, :answer)
    assert length(result.answer) == 4
    assert length(result.guesses) == 0
    assert result.answer == [1,2,3,4]
  end

  test "provided new test different size" do
    result = Game.new(%{answer: [1,2,3,4,5,6]})

    assert Map.has_key?(result, :guesses)
    assert Map.has_key?(result, :answer)
    assert length(result.answer) == 6
    assert length(result.guesses) == 0
    assert result.answer == [1,2,3,4,5,6]
  end

  test "guess" do
    state =
      Game.new(%{answer: [1,2,3,4]})
      |> Game.guess([3,2,1,4])

    assert Map.has_key?(state, :guesses)
    assert Map.has_key?(state, :answer)
    assert length(state.answer) == 4
    assert length(state.guesses) == 1
    assert state.guesses == [[3,2,1,4]]
  end

  test "two guesses" do
    state =
      Game.new(%{answer: [1,2,3,4]})
      |> Game.guess([3,2,1,4])
      |> Game.guess([4,3,2,1])

    assert Map.has_key?(state, :guesses)
    assert Map.has_key?(state, :answer)
    assert length(state.answer) == 4
    assert length(state.guesses) == 2
    assert state.guesses == [[4,3,2,1], [3,2,1,4]]
  end
end
