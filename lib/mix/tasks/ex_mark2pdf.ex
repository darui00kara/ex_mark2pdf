defmodule Mix.Tasks.ExMark2pdf do
  use Mix.Task

  @moduledoc """
  This module is Custom Task of Mix.
  It provides the ability to convert from the markdown to the PDF.

  ## Caution!!
       - UTF-8 encoding file only
       - Required wkhtmltopdf tool (Download: http://wkhtmltopdf.org/downloads.html)

  ## Examples

       >mix ex_mark2pdf path/to/markdown/file.md path/to/output/directory
       Loading pages (1/6)
       Counting pages (2/6)
       Resolving links (4/6)
       Loading headers and footers (5/6)
       Printing pages (6/6)
       Done

  """

  @shortdoc "Markdown file to PDF file Generator. Please markdown file!!"

  def run(args) do
    #Regex.match?(~r/.+.md$|.+.txt$/, markdown_file_path)
    #Regex.match?(~r/.+.pdf$/, pdf_output_name)
    markdown_to_pdf(args)
  end

  defp markdown_to_pdf(markdown) do
    timestamp = Tuple.to_list(:os.timestamp) |> Enum.join
    html_file_name = File.read!(markdown)
                     |> Earmark.to_html
                     |> create_temp_html_file(timestamp)

    wkhtmltopdf_execution(html_file_name, timestamp <> ".pdf")
    File.rm!(html_file_name)
  end

  defp create_temp_html_file(html, timestamp) do
    html_file_name = timestamp <> "_temp.html"

    File.touch!(html_file_name)
    write_html(html_file_name, html)

    html_file_name
  end

  defp write_html(file_name, html) do
    file = File.open!(file_name, [:write])
    IO.binwrite(file, html)
    File.close(file)
  end

  defp wkhtmltopdf_execution(html_file_name, pdf_file_name) do
    if cmd_path = System.find_executable("wkhtmltopdf") do
      {_, 0} = System.cmd(cmd_path, ["--encoding", "utf-8", html_file_name, pdf_file_name])
    end
  end
end