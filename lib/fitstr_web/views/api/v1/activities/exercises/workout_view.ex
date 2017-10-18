defmodule FitstrWeb.API.V1.Activities.Exercises.WorkoutView do
  use FitstrWeb, :view
  alias FitstrWeb.API.V1.Activities.Exercises.WorkoutView

  def render("index.json", %{workouts: workouts}) do
    %{data: render_many(workouts, WorkoutView, "workout.json")}
  end

  def render("show.json", %{workout: workout}) do
    %{data: render_one(workout, WorkoutView, "workout.json")}
  end

  def render("workout.json", %{workout: workout}) do
    %{id: workout.id,
      name: workout.name,
      description: workout.description,
      interval: workout.interval,
      round: workout.round,
      time: workout.time,
      note: workout.note}
  end
end
