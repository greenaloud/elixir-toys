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
    |> cast(params, [:name, :email, :phone_number])
    |> validate_required([:name, :email, :phone_number, :gender])
    |> validate_length(:email, min: 5)
  end
end
