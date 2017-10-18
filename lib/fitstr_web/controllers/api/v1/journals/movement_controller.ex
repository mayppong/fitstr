defmodule FitstrWeb.API.V1.Journals.MovementController do
  use FitstrWeb, :controller

  alias Fitstr.Journals
  alias Fitstr.Journals.Movement

  action_fallback FitstrWeb.FallbackController

  def index(conn, _params) do
    journal_movements = Journals.list_journal_movements()
    render(conn, "index.json", journal_movements: journal_movements)
  end

  def create(conn, %{"movement" => movement_params}) do
    with {:ok, %Movement{} = movement} <- Journals.create_movement(movement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_journals_movement_path(conn, :show, movement))
      |> render("show.json", movement: movement)
    end
  end

  def show(conn, %{"id" => id}) do
    movement = Journals.get_movement!(id)
    render(conn, "show.json", movement: movement)
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Journals.get_movement!(id)

    with {:ok, %Movement{} = movement} <- Journals.update_movement(movement, movement_params) do
      render(conn, "show.json", movement: movement)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Journals.get_movement!(id)
    with {:ok, %Movement{}} <- Journals.delete_movement(movement) do
      send_resp(conn, :no_content, "")
    end
  end
end
