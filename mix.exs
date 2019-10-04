defmodule Zaku.MixProject do
  use Mix.Project

  def project do
    [
      app: :zaku,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
    ]
  end

  def escript do
    [main_module: Zaku.CLI]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Zaku, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
     {:dir_walker, "~> 0.0.8"}
    ]
  end
end
