defmodule FitstrWeb.API.V1.Journals.Workouts.WorkoutView do
  use FitstrWeb, :view
  alias FitstrWeb.API.V1.Journals.Workouts.WorkoutView

  def render("index.json", %{journal_workouts: journal_workouts}) do
    %{data: render_many(journal_workouts, WorkoutView, "workout.json")}
  end

  def render("show.json", %{workout: workout}) do
    %{data: render_one(workout, WorkoutView, "workout.json")}
  end

  def render("workout.json", %{workout: workout}) do
    %{id: workout.id,
      interval: workout.interval,
      round: workout.round,
      time: workout.time,
      distance: workout.distance,
      energy: workout.energy,
      repetition: workout.repetition,
      weight: workout.weight,
      note: workout.note}
  end
end
