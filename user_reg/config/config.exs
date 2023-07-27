import Config

config :user_reg, Postgres.Repo,
  database: "postgres",
  username: "postgres",
  password: "test",
  hostname: "localhost",
  port: 5433

config :user_reg, ecto_repos: [Postgres.Repo]
