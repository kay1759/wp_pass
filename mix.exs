defmodule WPPass.MixProject do
  use Mix.Project

  @description """
  WordPress Password Check for elixir
  """

  def project do
    [
      app: :wp_pass,
      version: "0.1.1",
      elixir: "~> 1.14",
      name: "WPPass",
      description: @description,
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def package do
    [
      maintainers: ["Katsuyoshi Yabe"],
      licenses: ["MIT"],
      links: %{Github: "https://github.com/kay1759/wp_pass"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:white_bread, "~> 4.5", only: [:dev, :test]},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end
end
