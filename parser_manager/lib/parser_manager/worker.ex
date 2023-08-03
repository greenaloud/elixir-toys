defmodule ParserManager.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    Process.send_after(self(), :get_next_row, 0)
    {:ok, nil}
  end

  def handle_info(:get_next_row, _) do
    # case UserReg.Parser.next_row() do
    #   {:ok, row} ->
    #     sign_up_user(row)
    #     Process.send_after(self(), :get_next_row, 0)
    #     {:noreply, nil}

    #   nil ->
    #     {:stop, :normal, nil}
    # end
  end

  defp sign_up_user(params) do
    # case Postgres.User.sign_up(params) do
    #   {:ok, _user} ->
    #     # Logger.info("User #{params["name"]} signed up successfully")
    #     Process.send_after(self(), :get_next_row, 0)
    #     {:noreply, nil}

    #   {:error, _changeset} ->
    #     # Logger.error("User #{params["name"]} failed to sign up")
    #     # Logger.error("Reason: #{inspect(changeset.errors)}")
    #     {:stop, :normal, nil}
    # end
  end
end
