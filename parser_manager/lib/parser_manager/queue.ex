defmodule ParserManager.Queue do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def push(message) do
    GenServer.cast(__MODULE__, {:push, message})
  end

  def push_list(datas) do
    GenServer.cast(__MODULE__, {:push_list, datas})
  end

  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:push, message}, state) do
    {:noreply, state ++ [message]}
  end

  def handle_cast({:push_list, datas}, state) do
    IO.puts("[Queue] pushing list to queue")
    # Process.send_after(self(), :print_state, 0)
    {:noreply, Enum.concat(state, datas)}
  end

  def handle_info(:print_state, state) do
    IO.inspect(state)
    {:noreply, state}
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:pop, _from, [data | rest]) do
    {:reply, data, rest}
  end
end
