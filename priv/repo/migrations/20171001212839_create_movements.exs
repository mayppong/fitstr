defmodule Fitstr.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements) do
      add :name, :string
      add :description, :text
      add :parent_id, references(:movements, on_delete: :nothing)
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:movements, [:parent_id])
    create index(:movements, [:creator_id])
  end
end
