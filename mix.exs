defmodule WPPass.MixProject do
  use Mix.Project

  @description"""
  WordPress Password Check for elixir
  """
  
  def project do
    [
      app: :wp_pass,
      version: "0.1.0",
      elixir: "~> 1.11",
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
      links: %{ "Github": "https://github.com/kay1759/wp_pass" }
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
      { :white_bread, "~> 4.5", only: [:dev, :test] },
      { :ex_doc, "~> 0.19.3", only: :dev, runtime: false}
       # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
