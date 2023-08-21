import Config

config :parser_manager, Postgres.Repo,
  database: "postgres",
  username: "postgres",
  password: "test",
  hostname: "localhost",
  port: 5433

config :parser_manager, ecto_repos: [Postgres.Repo]
