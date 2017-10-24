defmodule Fitstr.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :order, :integer
      add :name, :string
      add :description, :text
      add :interval, :decimal
      add :round, :decimal
      add :time, :decimal
      add :distance, :decimal
      add :energy, :decimal
      add :repetition, :decimal
      add :weight, :decimal
      add :parent_id, references(:workouts, on_delete: :nothing)
      add :workout_id, references(:workouts, on_delete: :nothing)
      add :movement_id, references(:movements, on_delete: :nothing)
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:workouts, [:parent_id])
    create index(:workouts, [:workout_id])
    create index(:workouts, [:movement_id])
    create index(:workouts, [:creator_id])
  end
end
