defmodule ParserManager.Reporter do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def report(message) do
    GenServer.cast(__MODULE__, {:report, message})
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:report, message}, state) do
    IO.inspect(message)
    {:noreply, state ++ [message]}
  end
end
