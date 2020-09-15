defmodule SwedbankpayCheckout.MixProject do
  use Mix.Project

  def project do
    [
      app: :swedbankpay_checkout,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "swedbankpay_checkout",
      source_url: "https://github.com/hooplab/swedbank-pay-checkout-elixir"
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

  defp description() do
    "An elixir SDK built on Tesla for interacting with swedbank's checkout APIs, not official nor endorsed by swedbank."
  end

  defp package() do
    [
      name: "swedbankpay_checkout",
      licences: ["MIT"],
      links: %{"GitHub" => "https://github.com/hooplab/swedbank-pay-checkout-elixir"}
    ]
  end
end
