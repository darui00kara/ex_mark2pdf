defmodule Ex_Mark2Pdf.Timestamp do
  def get do
    Tuple.to_list(:os.timestamp) |> Enum.join
  end
end