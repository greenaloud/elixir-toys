defmodule ParserManager.Queue do
  use GenServer

  @me __MODULE__

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: @me)
  end

  def queue do
    GenServer.call(@me, :queue)
  end

  def push(message) do
    GenServer.cast(@me, {:push, message})
  end

  def push_list(datas) do
    GenServer.cast(@me, {:push_list, datas})
  end

  def pop() do
    GenServer.call(@me, :pop)
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:push, message}, state) do
    {:noreply, state ++ [message]}
  end

  def handle_cast({:push_list, datas}, state) do
    {:noreply, Enum.concat(state, datas)}
  end

  def handle_call(:queue, _from, state) do
    IO.inspect(state)
    {:reply, :ok, state}
  end

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end
end
