defmodule Mix.Tasks.ExMark2pdf do
  use Mix.Task

  @shortdoc "Markdown file to PDF file Generator."

  def run(args) do
    markdown_to_pdf(args)
  end

  defp markdown_to_html(markdown) do
    Earmark.to_html(markdown)
  end

  defp markdown_reader(markdown_file_path) do
    File.read!(markdown_file_path)
  end

  defp get_timestamp_string do
    Tuple.to_list(:os.timestamp) |> Enum.join
  end

  defp create_provisional_html_file(timestamp, html) do
    provisional_html_name = timestamp <> "_temp.html"

    File.touch!(provisional_html_name)
    write_html(provisional_html_name, html)

    provisional_html_name
  end

  defp write_html(path, html_data) do
    file = File.open!(path, [:write])
    IO.binwrite(file, html_data)
    File.close(file)
  end

  def markdown_to_pdf(markdown_file_path) do
    timestamp = get_timestamp_string
    html = markdown_reader(markdown_file_path) |> markdown_to_html
    provisional_html_name = create_provisional_html_file(timestamp, html)

    if cmd_path = System.find_executable("wkhtmltopdf") do
      {_, 0} = System.cmd(cmd_path, [provisional_html_name, timestamp <> ".pdf"])
    end

    File.rm!(provisional_html_name)
  end
end