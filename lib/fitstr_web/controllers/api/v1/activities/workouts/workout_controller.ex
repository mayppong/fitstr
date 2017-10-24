defmodule FitstrWeb.API.V1.Activities.Workouts.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Activities.Workouts
  alias Fitstr.Activities.Workouts.Workout

  action_fallback FitstrWeb.FallbackController

  def index(conn, _params) do
    workouts = Workouts.list_workouts()
    render(conn, "index.json", workouts: workouts)
  end

  def create(conn, %{"workout" => workout_params}) do
    with {:ok, %Workout{} = workout} <- Workouts.create_workout(workout_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_activities_workouts_workout_path(conn, :show, workout))
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
