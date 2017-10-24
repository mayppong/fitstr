defmodule FitstrWeb.Activities.Workouts.MovementController do
  use FitstrWeb, :controller

  alias Fitstr.Activities.Workouts
  alias Fitstr.Activities.Workouts.Movement

  def index(conn, _params) do
    movements = Workouts.list_movements()
    render(conn, "index.html", movements: movements)
  end

  def new(conn, _params) do
    changeset = Workouts.change_movement(%Movement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movement" => movement_params}) do
    case Workouts.create_movement(movement_params) do
      {:ok, movement} ->
        conn
        |> put_flash(:info, "Movement created successfully.")
        |> redirect(to: activities_workouts_movement_path(conn, :show, movement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movement = Workouts.get_movement!(id)
    render(conn, "show.html", movement: movement)
  end

  def edit(conn, %{"id" => id}) do
    movement = Workouts.get_movement!(id)
    changeset = Workouts.change_movement(movement)
    render(conn, "edit.html", movement: movement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Workouts.get_movement!(id)

    case Workouts.update_movement(movement, movement_params) do
      {:ok, movement} ->
        conn
        |> put_flash(:info, "Movement updated successfully.")
        |> redirect(to: activities_workouts_movement_path(conn, :show, movement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movement: movement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Workouts.get_movement!(id)
    {:ok, _movement} = Workouts.delete_movement(movement)

    conn
    |> put_flash(:info, "Movement deleted successfully.")
    |> redirect(to: activities_workouts_movement_path(conn, :index))
  end
end
