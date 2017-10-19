defmodule Fitstr.Activities.Exercises.Workout do
  @moduledoc """
  Data model for a workout. A workout may consists of multiple movements. The
  relationship between a workout and its movements is modelled by the
  `Fitstr.Activities.Exercises.WorkoutMovement`.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Activities.Exercises.Workout


  schema "workouts" do
    field :description, :string
    field :interval, :decimal
    field :name, :string
    field :note, :string
    field :round, :integer
    field :time, :decimal
    field :parent_id, :id
    field :creator_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Workout{} = workout, attrs) do
    workout
    |> cast(attrs, [:name, :description, :interval, :round, :time, :note])
    |> validate_required([:name, :description, :interval, :round, :time, :note])
  end
end
