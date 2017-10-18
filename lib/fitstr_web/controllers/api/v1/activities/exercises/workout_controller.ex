defmodule FitstrWeb.API.V1.Activities.Exercises.WorkoutController do
  use FitstrWeb, :controller

  alias Fitstr.Activities.Exercises
  alias Fitstr.Activities.Exercises.Workout

  action_fallback FitstrWeb.FallbackController

  def index(conn, _params) do
    workouts = Exercises.list_workouts()
    render(conn, "index.json", workouts: workouts)
  end

  def create(conn, %{"workout" => workout_params}) do
    with {:ok, %Workout{} = workout} <- Exercises.create_workout(workout_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_activities_exercises_workout_path(conn, :show, workout))
      |> render("show.json", workout: workout)
    end
  end

  def show(conn, %{"id" => id}) do
    workout = Exercises.get_workout!(id)
    render(conn, "show.json", workout: workout)
  end

  def update(conn, %{"id" => id, "workout" => workout_params}) do
    workout = Exercises.get_workout!(id)

    with {:ok, %Workout{} = workout} <- Exercises.update_workout(workout, workout_params) do
      render(conn, "show.json", workout: workout)
    end
  end

  def delete(conn, %{"id" => id}) do
    workout = Exercises.get_workout!(id)
    with {:ok, %Workout{}} <- Exercises.delete_workout(workout) do
      send_resp(conn, :no_content, "")
    end
  end
end
