defmodule ExMark2pdf.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_mark2pdf,
     version: "0.1.0",
     elixir: "~> 1.0",
     escript: [main_module: ExMark2pdf.Main],
     description: "Generate a PDF from Markdown file.",
     package: [
       contributors: ["darui00kara"],
       licenses: ["Free"],
       links: %{"GitHub" => "https://github.com/darui00kara/ex_mark2pdf"}
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:earmark, "~> 0.1.17"}]
  end
end
