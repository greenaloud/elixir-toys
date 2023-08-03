defmodule Postgres.Repo do
  use Ecto.Repo,
    otp_app: :user_reg,
    adapter: Ecto.Adapters.Postgres
end
