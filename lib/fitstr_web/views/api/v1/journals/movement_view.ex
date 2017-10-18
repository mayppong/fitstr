defmodule FitstrWeb.API.V1.Journals.MovementView do
  use FitstrWeb, :view
  alias FitstrWeb.API.V1.Journals.MovementView

  def render("index.json", %{journal_movements: journal_movements}) do
    %{data: render_many(journal_movements, MovementView, "movement.json")}
  end

  def render("show.json", %{movement: movement}) do
    %{data: render_one(movement, MovementView, "movement.json")}
  end

  def render("movement.json", %{movement: movement}) do
    %{id: movement.id,
      distance: movement.distance,
      energy: movement.energy,
      interval: movement.interval,
      repetition: movement.repetition,
      time: movement.time,
      weight: movement.weight,
      note: movement.note}
  end
end
