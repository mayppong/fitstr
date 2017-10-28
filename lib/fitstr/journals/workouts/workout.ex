defmodule Fitstr.Journals.Workouts.Workout do
  @moduledoc """
  Data model for recording a workout journal.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Journals.Workouts.Workout


  schema "journal_workouts" do
    field :distance, :decimal
    field :energy, :decimal
    field :interval, :decimal
    field :note, :string
    field :repetition, :decimal
    field :round, :decimal
    field :time, :decimal
    field :weight, :decimal
    field :user_id, :id
    field :parent_id, :id
    field :workout_id, :id
    field :movement_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Workout{} = workout, attrs) do
    workout
    |> cast(attrs, [:interval, :round, :time, :distance, :energy, :repetition, :weight, :note])
    |> validate_required([:interval, :round, :time, :distance, :energy, :repetition, :weight, :note])
  end
end
