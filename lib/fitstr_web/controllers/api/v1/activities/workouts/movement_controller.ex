defmodule FitstrWeb.API.V1.Activities.Workouts.MovementController do
  use FitstrWeb, :controller

  alias Fitstr.Activities.Workouts
  alias Fitstr.Activities.Workouts.Movement

  action_fallback FitstrWeb.FallbackController

  def index(conn, _params) do
    movements = Workouts.list_movements()
    render(conn, "index.json", movements: movements)
  end

  def create(conn, %{"movement" => movement_params}) do
    with {:ok, %Movement{} = movement} <- Workouts.create_movement(movement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_activities_workouts_movement_path(conn, :show, movement))
      |> render("show.json", movement: movement)
    end
  end

  def show(conn, %{"id" => id}) do
    movement = Workouts.get_movement!(id)
    render(conn, "show.json", movement: movement)
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Workouts.get_movement!(id)

    with {:ok, %Movement{} = movement} <- Workouts.update_movement(movement, movement_params) do
      render(conn, "show.json", movement: movement)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Workouts.get_movement!(id)
    with {:ok, %Movement{}} <- Workouts.delete_movement(movement) do
      send_resp(conn, :no_content, "")
    end
  end
end
