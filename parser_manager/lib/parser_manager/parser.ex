defmodule ParserManager.Parser do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: __MODULE__)
  end

  def init(:no_args) do
    # rows = File.stream!('user_data.csv') |> CSV.decode(headers: true) |> Enum.to_list()
    rows = 1
    Process.send_after(self(), :push_to_queue, 0)
    {:ok, rows}
  end

  def handle_info(:push_to_queue, rows) do
    IO.puts("[Parser] pushing to queue")
    # IO.inspect(rows)
    # IO.inspect(Enum.count(rows))
    # ParserManager.Queue.push_list(rows)
    ParserManager.Queue.push(rows)
    {:noreply, rows}
  end
end
