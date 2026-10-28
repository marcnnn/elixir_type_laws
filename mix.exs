defmodule TypeLaws.MixProject do
  use Mix.Project

  def project do
    [
      app: :type_laws,
      version: "0.1.0",
      elixir: "~> 1.17",
      description: "Set-theoretic laws as data, checked against Elixir's type system",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [licenses: ["Apache-2.0"]]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:nx_fixed, path: "../nx_fixed"},
      {:stream_data, "~> 1.1", only: [:dev, :test]}
    ]
  end
end
