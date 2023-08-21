defmodule Postgres.Repo do
  use Ecto.Repo,
    otp_app: :parser_manager,
    adapter: Ecto.Adapters.Postgres
end
