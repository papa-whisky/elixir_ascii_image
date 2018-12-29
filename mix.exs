defmodule ElixirAsciiImage.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_ascii_image,
      version: "0.1.0",
      elixir: "~> 1.7",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
    ]
  end
end
