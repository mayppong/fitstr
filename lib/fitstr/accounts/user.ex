defmodule Fitstr.Accounts.User do
  @moduledoc """
  Data struct for user account for the application.

  Though it contains a hashed_password field, it's not being used as the
  authentication is currently handle through Google's OAuth provider.
  """

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
    |> validate_required([:email])
    |> unique_constraint(:handler)
    |> unique_constraint(:email)
  end
end
