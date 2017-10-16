defmodule Fitstr.Repo.Migrations.CreateJournalMovements do
  use Ecto.Migration

  def change do
    create table(:journal_movements) do
      add :distance, :decimal
      add :energy, :decimal
      add :interval, :decimal
      add :repetition, :decimal
      add :time, :decimal
      add :weight, :decimal
      add :note, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :journal_workout_id, references(:journal_workouts, on_delete: :nothing)
      add :workout_movement_id, references(:workout_movements, on_delete: :nothing)
      add :movement_id, references(:movements, on_delete: :nothing)

      timestamps()
    end

    create index(:journal_movements, [:user_id])
    create index(:journal_movements, [:journal_workout_id])
    create index(:journal_movements, [:workout_movement_id])
    create index(:journal_movements, [:movement_id])
  end
end
