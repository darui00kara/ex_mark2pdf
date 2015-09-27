defmodule Ex_Mark2Pdf.Html2Pdf do
  def to_pdf(html) do
    timestamp = Ex_Mark2Pdf.Timestamp.get

    html_file_name = timestamp <> "_temp.html"
    pdf_file_name = timestamp <> "_temp.pdf"

    File.touch!(html_file_name)
    File.open!(html_file_name, [:write])
    |> IO.binwrite(html)
    |> File.close

    case wkhtmltopdf_execution(html_file_name, pdf_file_name) do
      {_, 0} ->
        pdf = File.read!(pdf_file_name)
        File.rm!(html_file_name)
        File.rm!(pdf_file_name)
        {:ok, pdf}
      _ ->
        File.rm!(html_file_name)
        File.rm!(pdf_file_name)
        {:error, nil}
    end
  end

  def to_pdf_with_file(html, pdf_file_name) do
    timestamp = Ex_Mark2Pdf.Timestamp.get

    html_file_name = timestamp <> "_temp.html"

    File.touch!(html_file_name)
    File.open!(html_file_name, [:write])
    |> IO.binwrite(html)
    |> File.close

    case wkhtmltopdf_execution(html_file_name, pdf_file_name) do
      {_, 0} ->
        pdf = File.read!(pdf_file_name)
        File.rm!(html_file_name)
        {:ok, pdf}
      _ ->
        File.rm!(html_file_name)
        {:error, nil}
    end
  end

  def wkhtmltopdf_execution(html_file_name, pdf_file_name) do
    if cmd_path = System.find_executable("wkhtmltopdf") do
      System.cmd(cmd_path, ["--encoding", "utf-8", html_file_name, pdf_file_name])
    else
      nil
    end
  end
end