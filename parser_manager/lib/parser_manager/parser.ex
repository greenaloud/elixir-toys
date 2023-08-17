defmodule ParserManager.Parser do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: __MODULE__)
  end

  def push_rows_to_queue() do
    GenServer.cast(__MODULE__, :push_to_queue)
  end

  def init(:no_args) do
    rows = File.stream!('user_data.csv') |> CSV.decode(headers: true) |> Enum.to_list()
    {:ok, rows}
  end

  def handle_cast(:push_to_queue, rows) do
    ParserManager.Queue.push_list(rows)
    Process.exit(self(), :shutdown)
  end
end
