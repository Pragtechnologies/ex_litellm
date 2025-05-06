defmodule ExLitellm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch,
       name: MyFinch,
       pools: %{
         default: [size: 70]
       }}
      # Starts a worker by calling: ExLitellm.Worker.start_link(arg)
      # {ExLitellm.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExLitellm.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
