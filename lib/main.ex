defmodule ExMark2pdf.Main do
  @moduledoc """
  This module is for building escript.
  It will generate a PDF from the mark-down.

  ## Note:
       - UTF-8 encoding file only
       - Required wkhtmltopdf tool (Download: http://wkhtmltopdf.org/downloads.html)

  """

  @shortdoc "Generate a PDF from Markdown file."

  def main(args) do
    unless rem(Enum.count(args), 2) == 0 do
      raise "Invalid option."
    end

    options = Enum.chunk(args, 2) |> Enum.reduce(Map.new, &put_option/2)
    check_required_options_exist(options)
    
    File.read!(options["-i"])
    |> Ex_Mark2Pdf.Mark2Html.to_html
    |> Ex_Mark2Pdf.Html2Pdf.to_pdf_with_file(options["-o"])
  end

  defp put_option([h|[t]], acc) when h == "-i" do
    if Regex.match?(~r/.+.md$|.+.txt$/, t) do
      Map.put(acc, h, t)
    else
      raise "-i option is invalid value. Please [file_name].md or [file_name].txt"
    end
  end

  defp put_option([h|[t]], acc) when h == "-o" do
    if Regex.match?(~r/.+.pdf$/, t) do
      Map.put(acc, h, t)
    else
      raise "-o option is invalid value. Please [file_name].pdf"
    end
  end

  defp check_required_options_exist(options) do
    unless Map.has_key?(options, "-i") do
      raise "Please -i option."
    end

    unless Map.has_key?(options, "-o") do
      raise "Please -o option."
    end
  end
end