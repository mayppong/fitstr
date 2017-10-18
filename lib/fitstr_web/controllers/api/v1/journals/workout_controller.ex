defmodule FitstrWeb.API.V1.Journals.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Journals
  alias Fitstr.Journals.Workout

  action_fallback FitstrWeb.FallbackController

  def index(conn, _params) do
    journal_workouts = Journals.list_journal_workouts()
    render(conn, "index.json", journal_workouts: journal_workouts)
  end

  def create(conn, %{"workout" => workout_params}) do
    with {:ok, %Workout{} = workout} <- Journals.create_workout(workout_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_journals_workout_path(conn, :show, workout))
      |> render("show.json", workout: workout)
    end
  end

  def show(conn, %{"id" => id}) do
    workout = Journals.get_workout!(id)
    render(conn, "show.json", workout: workout)
  end

  def update(conn, %{"id" => id, "workout" => workout_params}) do
    workout = Journals.get_workout!(id)

    with {:ok, %Workout{} = workout} <- Journals.update_workout(workout, workout_params) do
      render(conn, "show.json", workout: workout)
    end
  end

  def delete(conn, %{"id" => id}) do
    workout = Journals.get_workout!(id)
    with {:ok, %Workout{}} <- Journals.delete_workout(workout) do
      send_resp(conn, :no_content, "")
    end
  end
end
