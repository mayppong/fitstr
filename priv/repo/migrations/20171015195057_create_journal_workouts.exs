defmodule Fitstr.Repo.Migrations.CreateJournalWorkouts do
  use Ecto.Migration

  def change do
    create table(:journal_workouts) do
      add :interval, :decimal
      add :round, :decimal
      add :repetition, :integer
      add :time, :decimal
      add :note, :text
      add :parent_id, references(:journal_workouts, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :workout_id, references(:workouts, on_delete: :nothing)

      timestamps()
    end

    create index(:journal_workouts, [:parent_id])
    create index(:journal_workouts, [:user_id])
    create index(:journal_workouts, [:workout_id])
  end
end
