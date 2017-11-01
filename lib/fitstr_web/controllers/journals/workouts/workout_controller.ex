defmodule FitstrWeb.Journals.Workouts.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Journals.Workouts
  alias Fitstr.Journals.Workouts.Workout

  def index(conn, _params) do
    journal_workouts = Workouts.list_journal_workouts()
    render(conn, "index.html", journal_workouts: journal_workouts)
  end

  def new(conn, _params) do
    changeset = Workouts.change_workout(%Workout{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"workout" => workout_params}) do
    user = conn.assigns[:current_user]
    workout_params = workout_params |> Map.put("user_id", user.id)
    case Workouts.create_workout(workout_params) do
      {:ok, workout} ->
        conn
        |> put_flash(:info, "Workout created successfully.")
        |> redirect(to: journals_workouts_workout_path(conn, :show, workout))
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
        |> redirect(to: journals_workouts_workout_path(conn, :show, workout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", workout: workout, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    workout = Workouts.get_workout!(id)
    {:ok, _workout} = Workouts.delete_workout(workout)

    conn
    |> put_flash(:info, "Workout deleted successfully.")
    |> redirect(to: journals_workouts_workout_path(conn, :index))
  end
end
