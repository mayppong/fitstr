defmodule FitstrWeb.Journals.Workouts.WorkoutView do
  use FitstrWeb, :view

  alias Fitstr.Activities.Workouts.Movement
  alias Fitstr.Repo

  def movements() do
    moves = Movement
    |> Repo.all
    |> Enum.map(&("'#{&1.name}'"))
    |> Enum.join(", ")
    "[#{moves}]"
  end
end
