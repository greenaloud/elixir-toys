defmodule ParserManager.WorkerSupervisor do
  use GenServer

  @me WorkerSupervisor

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    Process.send_after(self(), :kickoff, 0)
    DynamicSupervisor.start_link(strategy: :one_for_one)
  end

  def handle_info(:kickoff, supervisor) do
    worker_count = 3
    1..worker_count
    |> Enum.each(fn _ -> add_worker() end)
    {:noreply, supervisor}
  end

  def add_worker() do
    {:ok, _pid} = DynamicSupervisor.start_child(@me, ParserManager.Worker)
  end
end
