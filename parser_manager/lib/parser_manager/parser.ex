defmodule ParserManager.Parser do
  use GenServer

  def start_link(file_path) do
    GenServer.start_link(__MODULE__, file_path, name: __MODULE__)
  end

  def init(file_path) do
    result = csv_parse(file_path)
    {:ok, result}
  end

  def csv_parse(file_path) do
    file_path
    # |> File.stream!()
    # |> CSV.decode()
    # |> Enum.map(fn [name, age] -> {name, String.to_integer(age)} end)
  end
end
