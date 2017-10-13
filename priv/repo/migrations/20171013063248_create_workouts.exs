defmodule Fitstr.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :name, :string
      add :description, :text
      add :interval, :decimal
      add :round, :integer
      add :time, :decimal
      add :parent_id, references(:workouts, on_delete: :nothing)
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:workouts, [:parent_id])
    create index(:workouts, [:creator_id])
  end
end
