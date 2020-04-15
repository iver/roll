defmodule Roll.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :roll,
      version: @version,
      elixir: ">= 1.7.4",
      start_permanent: Mix.env() == :prod,

      # Coverage
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      # Hex
      description: "Library that complements ecto migrations and their execution.",
      package: package(),

      # Docs
      name: "Roll",
      docs: docs(),
      source_url: "https://github.com/iver/roll",
      deps: deps()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "Roll",
      logo: "assets/logo.png",
      markdown_processor: ExDocMakeup,
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      maintainers: ["Iván Jaimes"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/iver/roll"},
      files: ~w(.formatter.exs mix.exs README.md CHANGELOG.md lib assets)
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ecto_sql]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, ">= 3.2.0"},
      {:postgrex, "~> 0.15.1"},
      {:credo, "~> 0.7", only: [:dev, :test]},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:ex_doc_makeup, "~> 0.1.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.12.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
