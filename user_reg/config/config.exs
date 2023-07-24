import Config

config :user_reg, Postgres.Repo,
  database: "postgres",
  username: "postgres",
  password: "test",
  hostname: "localhost"

config :user_reg, ecto_repos: [Postgres.Repo]
