defmodule Fitstr.Activities.Exercises do
  @moduledoc """
  The Activities.Exercises context.
  """

  import Ecto.Query, warn: false
  alias Fitstr.Repo

  alias Fitstr.Activities.Exercises.Movement

  @doc """
  Returns the list of movements.

  ## Examples

      iex> list_movements()
      [%Movement{}, ...]

  """
  def list_movements do
    Repo.all(Movement)
  end

  @doc """
  Gets a single movement.

  Raises `Ecto.NoResultsError` if the Movement does not exist.

  ## Examples

      iex> get_movement!(123)
      %Movement{}

      iex> get_movement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movement!(id), do: Repo.get!(Movement, id)

  @doc """
  Creates a movement.

  ## Examples

      iex> create_movement(%{field: value})
      {:ok, %Movement{}}

      iex> create_movement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movement(attrs \\ %{}) do
    %Movement{}
    |> Movement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movement.

  ## Examples

      iex> update_movement(movement, %{field: new_value})
      {:ok, %Movement{}}

      iex> update_movement(movement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movement(%Movement{} = movement, attrs) do
    movement
    |> Movement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Movement.

  ## Examples

      iex> delete_movement(movement)
      {:ok, %Movement{}}

      iex> delete_movement(movement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movement(%Movement{} = movement) do
    Repo.delete(movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movement changes.

  ## Examples

      iex> change_movement(movement)
      %Ecto.Changeset{source: %Movement{}}

  """
  def change_movement(%Movement{} = movement) do
    Movement.changeset(movement, %{})
  end

  alias Fitstr.Activities.Exercises.Workout

  @doc """
  Returns the list of workouts.

  ## Examples

      iex> list_workouts()
      [%Workout{}, ...]

  """
  def list_workouts do
    Repo.all(Workout)
  end

  @doc """
  Gets a single workout.

  Raises `Ecto.NoResultsError` if the Workout does not exist.

  ## Examples

      iex> get_workout!(123)
      %Workout{}

      iex> get_workout!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workout!(id), do: Repo.get!(Workout, id)

  @doc """
  Creates a workout.

  ## Examples

      iex> create_workout(%{field: value})
      {:ok, %Workout{}}

      iex> create_workout(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workout(attrs \\ %{}) do
    %Workout{}
    |> Workout.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workout.

  ## Examples

      iex> update_workout(workout, %{field: new_value})
      {:ok, %Workout{}}

      iex> update_workout(workout, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workout(%Workout{} = workout, attrs) do
    workout
    |> Workout.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Workout.

  ## Examples

      iex> delete_workout(workout)
      {:ok, %Workout{}}

      iex> delete_workout(workout)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workout(%Workout{} = workout) do
    Repo.delete(workout)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workout changes.

  ## Examples

      iex> change_workout(workout)
      %Ecto.Changeset{source: %Workout{}}

  """
  def change_workout(%Workout{} = workout) do
    Workout.changeset(workout, %{})
  end

  alias Fitstr.Activities.Exercises.WorkoutMovement

  @doc """
  Returns the list of workout_movements.

  ## Examples

      iex> list_workout_movements()
      [%WorkoutMovement{}, ...]

  """
  def list_workout_movements do
    Repo.all(WorkoutMovement)
  end

  @doc """
  Gets a single workout_movement.

  Raises `Ecto.NoResultsError` if the Workout movement does not exist.

  ## Examples

      iex> get_workout_movement!(123)
      %WorkoutMovement{}

      iex> get_workout_movement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workout_movement!(id), do: Repo.get!(WorkoutMovement, id)

  @doc """
  Creates a workout_movement.

  ## Examples

      iex> create_workout_movement(%{field: value})
      {:ok, %WorkoutMovement{}}

      iex> create_workout_movement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workout_movement(attrs \\ %{}) do
    %WorkoutMovement{}
    |> WorkoutMovement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workout_movement.

  ## Examples

      iex> update_workout_movement(workout_movement, %{field: new_value})
      {:ok, %WorkoutMovement{}}

      iex> update_workout_movement(workout_movement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workout_movement(%WorkoutMovement{} = workout_movement, attrs) do
    workout_movement
    |> WorkoutMovement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a WorkoutMovement.

  ## Examples

      iex> delete_workout_movement(workout_movement)
      {:ok, %WorkoutMovement{}}

      iex> delete_workout_movement(workout_movement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workout_movement(%WorkoutMovement{} = workout_movement) do
    Repo.delete(workout_movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workout_movement changes.

  ## Examples

      iex> change_workout_movement(workout_movement)
      %Ecto.Changeset{source: %WorkoutMovement{}}

  """
  def change_workout_movement(%WorkoutMovement{} = workout_movement) do
    WorkoutMovement.changeset(workout_movement, %{})
  end
end
