defmodule Fitstr.Journals.Movement do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Journals.Movement


  schema "journal_movements" do
    field :distance, :decimal
    field :energy, :decimal
    field :interval, :decimal
    field :note, :string
    field :repetition, :decimal
    field :time, :decimal
    field :weight, :decimal
    field :user_id, :id
    field :journal_workout_id, :id
    field :workout_movement_id, :id
    field :movement_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Movement{} = movement, attrs) do
    movement
    |> cast(attrs, [:distance, :energy, :interval, :repetition, :time, :weight, :note])
    |> validate_required([:distance, :energy, :interval, :repetition, :time, :weight, :note])
  end
end
