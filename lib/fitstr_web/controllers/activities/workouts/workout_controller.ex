defmodule FitstrWeb.Activities.Workouts.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Activities.Workouts
  alias Fitstr.Activities.Workouts.Workout

  def index(conn, _params) do
    workouts = Workouts.list_workouts()
    render(conn, "index.html", workouts: workouts)
  end

  def new(conn, _params) do
    changeset = Workouts.change_workout(%Workout{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"workout" => workout_params}) do
    case Workouts.create_workout(workout_params) do
      {:ok, workout} ->
        conn
        |> put_flash(:info, "Workout created successfully.")
        |> redirect(to: activities_workouts_workout_path(conn, :show, workout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    workout = Workouts.get_workout!(id)
    render(conn, "show.html", workout: workout)
  end

  def edit(conn, %{"id" => id}) do
    workout = Workouts.get_workout!(id)
    changeset = Workouts.change_workout(workout)
    render(conn, "edit.html", workout: workout, changeset: changeset)
  end

  def update(conn, %{"id" => id, "workout" => workout_params}) do
    workout = Workouts.get_workout!(id)

    case Workouts.update_workout(workout, workout_params) do
      {:ok, workout} ->
        conn
        |> put_flash(:info, "Workout updated successfully.")
        |> redirect(to: activities_workouts_workout_path(conn, :show, workout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", workout: workout, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    workout = Workouts.get_workout!(id)
    {:ok, _workout} = Workouts.delete_workout(workout)

    conn
    |> put_flash(:info, "Workout deleted successfully.")
    |> redirect(to: activities_workouts_workout_path(conn, :index))
  end
end
