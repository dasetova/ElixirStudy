defmodule Pbt.MixProject do
  use Mix.Project

  def project do
    [
      app: :pbt,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    apps = [:logger]

    extra_apps =
      if Mix.env() == :test do
        apps ++ [:propcheck]
      else
        apps
      end

    [
      applications: extra_apps
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:propcheck, "~> 1.0", only: :test}
    ]
  end
end
