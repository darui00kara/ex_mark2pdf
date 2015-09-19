defmodule Mix.Tasks.ExMark2pdf do
  defp markdown_to_html(markdown) do
    Earmark.to_html(markdown)
  end

  defp markdown_reader(markdown_file_path) do
    File.read!(markdown_file_path)
  end

  defp get_timestamp_string do
    {mega_secs, secs, micro_secs} = :os.timestamp
    Integer.to_string(mega_secs) <> Integer.to_string(secs) <> Integer.to_string(micro_secs)
  end

  defp create_provisional_html_file do
    provisional_html_name = get_timestamp <> "_provisional" <> ".html"
    File.touch!(provisional_html_name)

    provisional_html_name
  end

  defp write_html(path, html_data) do
    file = File.open!(path, [:write])
    IO.binwrite(file, html_data)
    File.close(file)
  end

  def markdown_to_pdf(markdown_file_path) do
    provisional_html_name = create_provisional_html_file
    html = markdown_reader(markdown_file_path) |> markdown_to_html

    write_html(provisional_html_name, html)

    if cmd_path = System.find_executable("wkhtmltopdf") do
      output_pdf_name = get_timestamp <> "_result.pdf"
      {result, 0} = System.cmd(cmd_path, [provisional_html_name, output_pdf_name])
    end

    File.rm!(provisional_html_name)
  end
end