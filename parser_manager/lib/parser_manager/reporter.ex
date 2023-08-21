defmodule ParserManager.Reporter do
  use GenServer

  @me ParserManagerReporter

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: @me)
  end

  def report_success(message) do
    GenServer.cast(@me, {:report_success, message})
  end

  def report_failure(message) do
    GenServer.cast(@me, {:report_success, message})
  end

  def report_finish() do
    GenServer.cast(@me, :report_finish)
  end

  def save_report_to_file(file_name) do
    GenServer.call(@me, {:save_report_to_file, file_name})
  end

  def init(:ok) do
    worker_count = 3
    Process.send_after(self(), {:kickoff, worker_count}, 0)
    {:ok, %{ worker_cout: worker_count }}
  end

  def handle_info({:kickoff, worker_count}, state) do
    1..worker_count
    |> Enum.each(fn _ -> ParserManager.WorkerSupervisor.add_worker() end)
    {:noreply, state}
  end

  def handle_cast({:report_success, message}, results) do
    new_results =
      Map.update(results, :success, [message], fn messages -> [message | messages] end)
    {:noreply, new_results}
  end

  def handle_cast({:report_failure, message}, results) do
    new_results =
      Map.update(results, :failure, [message], fn messages -> [message | messages] end)
    {:noreply, new_results}
  end

  def handle_cast(:report_finish, results) do
    case results do
      %{worker_count: 1} ->
        GenServer.call(__MODULE__, {:save_report_to_file, "report.txt"})
        Process.exit(self(), :shutdown)
        {:noreply, results}
      _ ->
        new_results = Map.update(results, :worker_count, 0, fn worker_count -> worker_count - 1 end)
        {:noreply, new_results}
    end

  end

  def handle_call({:save_report_to_file, file_name}, _from, results) do
    File.write(file_name, inspect(results))
    {:reply, :ok, results}
  end
end
