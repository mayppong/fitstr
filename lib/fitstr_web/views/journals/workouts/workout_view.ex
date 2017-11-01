defmodule FitstrWeb.Journals.Workouts.WorkoutView do
  use FitstrWeb, :view

  alias Fitstr.Activities.Workouts.Movement
  alias Fitstr.Repo

  def movements() do
    Movement
    |> Repo.all
    |> Enum.map(&{&1.name, &1.id})
  end
end
