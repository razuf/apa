defmodule Apa.MixProject do
  @moduledoc """
  Standard `MixProject`.
  """
  use Mix.Project

  def project do
    [
      app: :apa,
      version: "0.5.2",
      elixir: "~> 1.10",
      deps: deps(),
      name: "Apa",
      source_url: "https://github.com/razuf/apa",
      docs: [main: "readme", extras: ["README.md"]],
      description: description(),
      package: package(),
      dialyzer: dialyzer(),
      test_coverage: test_coverage(),
      preferred_cli_env: preferred_cli_env()
    ]
  end

  defp dialyzer() do
    [
      plt_add_deps: [:apps_direct],
      plt_add_apps: [:mix],
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp test_coverage do
    [
      tool: ExCoveralls
    ]
  end

  defp preferred_cli_env do
    [
      "coveralls.detail": :test,
      "coveralls.html": :test,
      "coveralls.json": :test,
      coveralls: :test
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:credo, "~> 1.3", only: [:dev], runtime: false},
      {:stream_data, "~> 0.1", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp description() do
    "APA - Arbitrary precision arithmetic."
  end

  defp package() do
    [
      name: "apa",
      maintainers: ["Ralph Zühlsdorf"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/razuf/apa"}
    ]
  end
end
