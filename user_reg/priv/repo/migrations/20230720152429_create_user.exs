defmodule Postgres.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :gender, :string, null: false
      add :phone_number, :string, null: true
    end
  end
end
