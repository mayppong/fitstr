defmodule Fitstr.Activities.Workouts.Workout do
  @moduledoc """
  Data model for creating a workout to journal.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Activities.Workouts.Workout


  schema "workouts" do
    field :description, :string
    field :distance, :decimal
    field :energy, :decimal
    field :interval, :decimal
    field :name, :string
    field :order, :integer
    field :repetition, :decimal
    field :round, :decimal
    field :time, :decimal
    field :weight, :decimal
    field :parent_id, :id
    field :workout_id, :id
    field :movement_id, :id
    field :creator_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Workout{} = workout, attrs) do
    workout
    |> cast(attrs, [:order, :name, :description, :interval, :round, :time, :distance, :energy, :repetition, :weight])
    |> validate_required([:order, :name, :description, :interval, :round, :time, :distance, :energy, :repetition, :weight])
  end
end
