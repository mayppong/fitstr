defmodule Fitstr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Accounts.User


  schema "users" do
    field :email, :string
    field :handler, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:handler, :email, :hashed_password])
    |> validate_required([:handler, :email, :hashed_password])
    |> unique_constraint(:handler)
    |> unique_constraint(:email)
  end
end