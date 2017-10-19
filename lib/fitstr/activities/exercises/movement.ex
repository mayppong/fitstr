defmodule Fitstr.Activities.Exercises.Movement do
  @moduledoc """
  Data model for exercise movements.

  The movements can be organized as a group of similar movements by
  referencing its parent using the `parent_id`. For example, the data for a
  squat movement may look like this.
  ```
  Squat %{id: 1}
   |-- Back Squat %{id: 2, parent_id: 1}
   |    \-- Paused Back Squat %{id: 5, parent_id: 2}
   |-- Front Squat %{id: 3, parent_id: 1}
   \-- Overhead Squat %{id: 4, parent_id: 1}
  ```
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Activities.Exercises.Movement


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
