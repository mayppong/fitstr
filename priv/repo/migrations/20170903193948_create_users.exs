defmodule Fitstr.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :handler, :string
      add :email, :string
      add :hashed_password, :string

      timestamps()
    end

    create unique_index(:users, [:handler])
    create unique_index(:users, [:email])
  end
end
