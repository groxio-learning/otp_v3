defmodule Chocula.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Chocula.Worker.start_link(arg)
      # {Chocula.Worker, arg}
      %{id: :server1, start: {Chocula.Server, :start_link, [:server1, "84"]}},
      %{id: :server2, start: {Chocula.Server, :start_link, [:server2, "21"]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chocula.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
