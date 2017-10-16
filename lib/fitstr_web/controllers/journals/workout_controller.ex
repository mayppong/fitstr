defmodule FitstrWeb.Journals.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Journals
  alias Fitstr.Journals.Workout

  def index(conn, _params) do
    journal_workouts = Journals.list_journal_workouts()
    render(conn, "index.html", journal_workouts: journal_workouts)
  end

  def new(conn, _params) do
    changeset = Journals.change_workout(%Workout{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"workout" => workout_params}) do
    case Journals.create_workout(workout_params) do
      {:ok, workout} ->
        conn
        |> put_flash(:info, "Workout created successfully.")
        |> redirect(to: journals_workout_path(conn, :show, workout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    workout = Journals.get_workout!(id)
    render(conn, "show.html", workout: workout)
  end

  def edit(conn, %{"id" => id}) do
    workout = Journals.get_workout!(id)
    changeset = Journals.change_workout(workout)
    render(conn, "edit.html", workout: workout, changeset: changeset)
  end

  def update(conn, %{"id" => id, "workout" => workout_params}) do
    workout = Journals.get_workout!(id)

    case Journals.update_workout(workout, workout_params) do
      {:ok, workout} ->
        conn
        |> put_flash(:info, "Workout updated successfully.")
        |> redirect(to: journals_workout_path(conn, :show, workout))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", workout: workout, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    workout = Journals.get_workout!(id)
    {:ok, _workout} = Journals.delete_workout(workout)

    conn
    |> put_flash(:info, "Workout deleted successfully.")
    |> redirect(to: journals_workout_path(conn, :index))
  end
end
