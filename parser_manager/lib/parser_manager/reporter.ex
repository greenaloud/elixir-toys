defmodule ParserManager.Reporter do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def report_success(message) do
    GenServer.cast(__MODULE__, {:report_success, message})
  end

  def report_failure(message) do
    GenServer.cast(__MODULE__, {:report_success, message})
  end

  def save_report_to_file(file_name) do
    GenServer.cast(__MODULE__, {:save_report_to_file, file_name})
  end

  def init(:ok) do
    {:ok, %{}}
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

  def handle_cast({:save_report_to_file, file_name}, results) do
    File.write(file_name, inspect(results))
    {:stop, :normal, :ok}
  end
end
