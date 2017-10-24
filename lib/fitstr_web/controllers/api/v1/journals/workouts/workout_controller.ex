defmodule FitstrWeb.API.V1.Journals.Workouts.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Journals.Workouts
  alias Fitstr.Journals.Workouts.Workout

  action_fallback FitstrWeb.FallbackController

  def index(conn, _params) do
    journal_workouts = Workouts.list_journal_workouts()
    render(conn, "index.json", journal_workouts: journal_workouts)
  end

  def create(conn, %{"workout" => workout_params}) do
    with {:ok, %Workout{} = workout} <- Workouts.create_workout(workout_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_journals_workouts_workout_path(conn, :show, workout))
      |> render("show.json", workout: workout)
    end
  end

  def show(conn, %{"id" => id}) do
    workout = Workouts.get_workout!(id)
    render(conn, "show.json", workout: workout)
  end

  def update(conn, %{"id" => id, "workout" => workout_params}) do
    workout = Workouts.get_workout!(id)

    with {:ok, %Workout{} = workout} <- Workouts.update_workout(workout, workout_params) do
      render(conn, "show.json", workout: workout)
    end
  end

  def delete(conn, %{"id" => id}) do
    workout = Workouts.get_workout!(id)
    with {:ok, %Workout{}} <- Workouts.delete_workout(workout) do
      send_resp(conn, :no_content, "")
    end
  end
end
