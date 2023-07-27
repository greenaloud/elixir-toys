defmodule UserReg.Parser do
  use GenServer

  @me Parser

  def start_link(file_path) do
    GenServer.start_link(__MODULE__, file_path, name: @me)
  end

  def next_row() do
    GenServer.call(@me, :next_row)
  end

  def state() do
    GenServer.call(@me, :state)
  end

  def init(file_path) do
    rows = File.stream!(file_path) |> CSV.decode(headers: true) |> Enum.to_list()
    Process.send_after(self(), :kickoff, 0)
    {:ok, rows}
  end

  def handle_info(:kickoff, state) do
    1..3
    |> Enum.each(fn _ -> UserReg.WorkerSupervisor.add_worker() end)
    {:noreply, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:next_row, _from, [row | rest]) do
    {:reply, row, rest}
  end

  def handle_call(:next_row, _from, []) do
    {:reply, nil, []}
  end
end
