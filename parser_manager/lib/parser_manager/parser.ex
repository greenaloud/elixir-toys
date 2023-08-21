defmodule ParserManager.Parser do
  use GenServer

  @me Parser

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def state do
    GenServer.call(@me, :state)
  end

  def init(:no_args) do
    rows = File.stream!('user_data.csv') |> CSV.decode(headers: true) |> Enum.to_list()
    Process.send_after(self(), :push_to_queue, 0)
    {:ok, rows}
  end

  def handle_info(:push_to_queue, rows) do
    ParserManager.Queue.push_list(rows)
    {:noreply, rows}
  end

  def handle_call(:state, _from, state) do
    IO.inspect(state)
    {:reply, :ok, state}
  end
end
