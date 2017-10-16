defmodule Fitstr.Activities.Exercises.WorkoutMovement do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Activities.Exercises.WorkoutMovement


  schema "workout_movements" do
    field :distance, :decimal
    field :energy, :decimal
    field :interval, :decimal
    field :order, :integer
    field :repetition, :decimal
    field :time, :decimal
    field :weight, :decimal
    field :workout_id, :id
    field :movement_id, :id

    timestamps()
  end

  @doc false
  def changeset(%WorkoutMovement{} = workout_movement, attrs) do
    workout_movement
    |> cast(attrs, [:order, :distance, :energy, :interval, :repetition, :time, :weight])
    |> validate_required([:order, :distance, :energy, :interval, :repetition, :time, :weight])
  end
end
