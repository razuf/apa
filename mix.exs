defmodule Apa.MixProject do
  @moduledoc """
  Standard `MixProject`.
  """
  use Mix.Project

  def project do
    [
      app: :apa,
      version: "0.3.0",
      elixir: "~> 1.9",
      deps: deps(),
      name: "Apa",
      source_url: "https://github.com/razuf/apa",
      docs: [main: "readme", extras: ["README.md"]],
      description: description(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:credo, "~> 1.3", only: [:dev, :test], runtime: false},
      {:stream_data, "~> 0.1", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description() do
    "Arbitrary precision arithmetic."
  end

  defp package() do
    [
      maintainers: ["Ralph Zühlsdorf"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/razuf/apa"}
    ]
  end
end
