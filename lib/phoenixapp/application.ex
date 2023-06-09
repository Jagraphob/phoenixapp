defmodule Phoenixapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixappWeb.Telemetry,
      # Start the Ecto repository
      Phoenixapp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phoenixapp.PubSub},
      # Start Finch
      {Finch, name: Phoenixapp.Finch},
      # Start the Endpoint (http/https)
      PhoenixappWeb.Endpoint
      # Start a worker by calling: Phoenixapp.Worker.start_link(arg)
      # {Phoenixapp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phoenixapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
