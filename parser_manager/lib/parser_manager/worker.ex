defmodule ParserManager.Worker do
  use GenServer
  alias ParserManager.Queue

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    Process.send_after(self(), :get_next_row, 0)
    {:ok, nil}
  end

  def handle_info(:get_next_row, _) do
    case Queue.pop() do
      nil ->
        ParserManager.Reporter.report_finish()
        {:stop, :normal, nil}
      row -> sign_up_user(row)
    end
  end

  defp sign_up_user(params) do
    case Postgres.User.sign_up(params) do
      {:ok, _user} ->
        ParserManager.Reporter.report_success("User #{params["name"]} signed up successfully")
        Process.send_after(self(), :get_next_row, 0)
        {:noreply, nil}

      {:error, _changeset} ->
        ParserManager.Reporter.report_failure("User #{params["name"]} failed to sign up")
        Process.send_after(self(), :get_next_row, 0)
        {:noreply, nil}
    end
  end
end
