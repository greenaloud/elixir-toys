defmodule Postgres.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string
    field :email, :string
    field :gender, :string
    field :phone_number, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :email, :gender, :phone_number])
    |> validate_required([:name, :email, :phone_number, :gender])
    |> validate_length(:email, min: 5)
  end

  def sign_up(params) do
    %Postgres.User{}
    |> changeset(params)
    |> Postgres.Repo.insert()
  end
end
