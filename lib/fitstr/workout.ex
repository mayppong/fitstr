defmodule Fitstr.Workout do
  @moduledoc """
  The structure of the data is very similar to
  `Fitstr.Journals.Workouts.Workout`. Essentially the workout activity acts
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

  import Ecto.Changeset

  @doc """
  Appropriately validate the changeset based on node type. The node type is
  first identified as one of root node, movement leaf, or sub-workout node,
  then an appropriate validation function is called.
  """
  @spec validate_node(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  def validate_node(changeset) do
    parent = get_field(changeset, :parent_id)
    movement = get_field(changeset, :movement_id)
    workout = get_field(changeset, :workout_id)

    {parent, movement, workout}
    |> case do
      {nil, nil, nil} -> changeset |> validate_root()
      {parent, movement, nil} when not(is_nil(parent) and is_nil(movement)) ->
        changeset |> validate_movement()
      {parent, nil, workout} when not(is_nil(parent) and is_nil(workout)) ->
        changeset |> validate_subworkout()
      _ ->
        [:name, :parent_id, :workout_id, :movement_id]
        |> Enum.reduce(changeset, fn(k, c) ->
           add_error(c, k, "name, parent_id, workout_id, movement_id can't all be blank")
        end)
    end
  end

  @doc """
  """
  @spec validate_root(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  def validate_root(changeset) do
    changeset
    |> validate_required([:name])
  end

  @doc """
  """
  @spec validate_movement(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  def validate_movement(changeset) do
    changeset
    |> validate_required([:order])
    |> assoc_constraint(:parent)
  end

  @doc """
  """
  @spec validate_subworkout(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  def validate_subworkout(changeset) do
    changeset
    |> validate_required([:order])
    |> assoc_constraint(:parent)
  end
end
