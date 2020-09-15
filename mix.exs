defmodule SwedpayCheckout.MixProject do
  use Mix.Project

  def project do
    [
      app: :swedpay_checkout,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:poison, "~> 3.1"},
      {:inflex, "~> 2.0.0"},
      {:jason, "~> 1.2", only: :test}
    ]
  end
end
