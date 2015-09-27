defmodule Ex_Mark2Pdf.Mark2Html do
  def to_html(markdown) do
    Earmark.to_html markdown
  end
end