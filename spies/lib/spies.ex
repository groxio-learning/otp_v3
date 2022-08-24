defmodule Spies do
  def new_game(name) do
    DynamicSupervisor.start_child(:sup, {Spies.Server, name})
  end

  def guess(name, guess) do
    Spies.Server.guess(name, guess)
  end

end
