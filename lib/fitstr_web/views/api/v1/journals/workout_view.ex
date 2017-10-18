defmodule FitstrWeb.API.V1.Journals.WorkoutView do
  use FitstrWeb, :view
  alias FitstrWeb.API.V1.Journals.WorkoutView

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
      repetition: workout.repetition,
      time: workout.time,
      note: workout.note}
  end
end
