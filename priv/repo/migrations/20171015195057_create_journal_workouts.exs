defmodule Fitstr.Repo.Migrations.CreateJournalWorkouts do
  use Ecto.Migration

  def change do
    create table(:journal_workouts) do
      add :interval, :decimal
      add :round, :decimal
      add :time, :decimal
      add :distance, :decimal
      add :energy, :decimal
      add :repetition, :decimal
      add :weight, :decimal
      add :note, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :parent_id, references(:journal_workouts, on_delete: :nothing)
      add :workout_id, references(:workouts, on_delete: :nothing)
      add :movement_id, references(:movements, on_delete: :nothing)

      timestamps()
    end

    create index(:journal_workouts, [:user_id])
    create index(:journal_workouts, [:parent_id])
    create index(:journal_workouts, [:workout_id])
    create index(:journal_workouts, [:movement_id])
  end
end
