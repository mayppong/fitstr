defmodule Fitstr.Activities.Workouts.Movement do
  @docmodule """
  Data model for exercise movements for workouts.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Activities.Workouts.Movement


  schema "movements" do
    field :description, :string
    field :name, :string
    field :parent_id, :id
    field :creator_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Movement{} = movement, attrs) do
    movement
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
