defmodule ParserManager.Manager do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      ParserManager.Parser,
      ParserManager.Reporter,
      ParserManager.Register,
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
