defmodule ParserManager.Parser do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: __MODULE__)
  end

  def init(:no_args) do
    rows = File.stream!('user_data.csv') |> CSV.decode(headers: true) |> Enum.to_list()
    Process.send_after(self(), :push_to_queue, 0)
    {:ok, rows}
  end

  def handle_call(:push_to_queue, _from, rows) do
    ParserManager.Queue.push_list(rows)
    {:stop, :normal, nil}
  end
end
