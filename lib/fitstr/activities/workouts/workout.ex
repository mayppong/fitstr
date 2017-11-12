defmodule Fitstr.Activities.Workouts.Workout do
  @moduledoc """
  Data model for creating a workout to journal.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Activities.Workouts.Workout


  schema "workouts" do
    field :name, :string
    field :description, :string
    field :order, :integer

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
    belongs_to :creator, Fitstr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Workout{} = workout, attrs) do
    workout
    |> cast(attrs, [:parent_id, :workout_id, :movement_id, :creator_id,
      :order, :name, :description,
      :interval, :round, :time, :distance, :energy, :repetition, :weight])
  end
end
