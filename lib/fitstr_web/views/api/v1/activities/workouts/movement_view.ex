defmodule FitstrWeb.API.V1.Activities.Workouts.MovementView do
  use FitstrWeb, :view
  alias FitstrWeb.API.V1.Activities.Workouts.MovementView

  def render("index.json", %{movements: movements}) do
    %{data: render_many(movements, MovementView, "movement.json")}
  end

  def render("show.json", %{movement: movement}) do
    %{data: render_one(movement, MovementView, "movement.json")}
  end

  def render("movement.json", %{movement: movement}) do
    %{id: movement.id,
      name: movement.name,
      description: movement.description}
  end
end
