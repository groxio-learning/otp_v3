defmodule Spies.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias Spies.Server
  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("Starting Application")
    children = [
      # Starts a worker by calling: Spies.Worker.start_link(arg)
      # {Server, :batman},
      # {Server, :hulk},
      # {Server, :spidey},
      # {Server, :strange},
      # {Server, :groot},
      {DynamicSupervisor, strategy: :one_for_one, name: :sup}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Spies.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
