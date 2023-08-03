defmodule ParserManager.Queue do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def push(message) do
    GenServer.cast(__MODULE__, {:push, message})
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:push, message}, state) do
    {:noreply, state ++ [message]}
  end
end
