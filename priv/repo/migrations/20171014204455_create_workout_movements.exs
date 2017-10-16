defmodule Fitstr.Repo.Migrations.CreateWorkoutMovements do
  use Ecto.Migration

  def change do
    create table(:workout_movements) do
      add :order, :integer
      add :distance, :decimal
      add :energy, :decimal
      add :interval, :decimal
      add :repetition, :decimal
      add :time, :decimal
      add :weight, :decimal
      add :workout_id, references(:workouts, on_delete: :nothing)
      add :movement_id, references(:movements, on_delete: :nothing)

      timestamps()
    end

    create index(:workout_movements, [:workout_id])
    create index(:workout_movements, [:movement_id])
  end
end
