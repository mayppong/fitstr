defmodule Fitstr.Journals.Workout do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Journals.Workout


  schema "journal_workouts" do
    field :interval, :decimal
    field :note, :string
    field :repetition, :integer
    field :round, :decimal
    field :time, :decimal
    field :parent_id, :id
    field :user_id, :id
    field :workout_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Workout{} = workout, attrs) do
    workout
    |> cast(attrs, [:interval, :round, :repetition, :time, :note])
    |> validate_required([:interval, :round, :repetition, :time, :note])
  end
end
