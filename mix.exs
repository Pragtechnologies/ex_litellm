defmodule ExLitellm.MixProject do
  use Mix.Project

  @version "0.1.0"
  @name "ExLitellm"
  @organization "pragtechnologies"
  @description "Elixir library for LiteLLM"
  @git "https://github.com/Pragtechnologies/ex_litellm"

  def project do
    [
      app: :ex_litellm,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Docs
      name: @name,
      source_url: @git,
      homepage_url: "https://www.pragtechnologies.com/",
      description: @description,
      package: package(),
      aliases: aliases(),
      docs: [
        # The main page in the docs
        main: @name,
        logo: "logo.svg",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ExLitellm.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.5.9"},
      {:jason, "~> 1.4"},
      {:exvcr, "~> 0.17.0"},
      {:hackney, "~> 1.23"},
      {:ex_doc, "~> 0.37", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18", only: [:test]},
      {:credo, "~> 1.7", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      check: ["dialyzer", "credo"]
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @git},
      maintainers: [@organization]
    ]
  end
end
