defmodule Fitstr.Journals.Workouts.Workout do
  @moduledoc """
  Data model for recording a workout activity.

  The structure of the data is very similar to
  `Fitstr.Activities.Workouts.Workout`. Essentially the workout activity acts
  as the template to the workout journal. The activity represents what the
  plan while the journal represents what actually happens.

  There are three different data types that can be stored.
  1. A root node is a row where `movement_id`, `parent_id`, and `workout_id`
     are `nil`.
  2. A movement leaf is a row where a parent and movement are referenced. This
     means the row is part of a workout, and the movement is specified.
  3. A sub-workout reference is a row where a parent and another workout are
     referenced. This means the row is part of a workout and there are more
     than one movement required.

  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Journals.Workouts.Workout


  schema "journal_workouts" do
    field :note, :string

    field :distance, :decimal
    field :energy, :decimal
    field :interval, :decimal
    field :repetition, :decimal
    field :round, :decimal
    field :time, :decimal
    field :weight, :decimal

    belongs_to :parent, __MODULE__

    belongs_to :workout, __MODULE__
    belongs_to :movement, Fitstr.Activities.Workouts.Movement
    belongs_to :user, Fitstr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Workout{} = workout, attrs) do
    workout
    |> cast(attrs, [:user_id, :parent_id, :workout_id, :movement_id,
      :interval, :round, :time, :distance, :energy, :repetition, :weight,
      :note])
    |> validate_required([:user_id, :movement_id])
  end
end
