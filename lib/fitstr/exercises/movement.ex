defmodule Fitstr.Exercises.Movement do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fitstr.Exercises.Movement


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
