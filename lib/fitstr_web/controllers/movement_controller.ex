defmodule FitstrWeb.MovementController do
  use FitstrWeb, :controller

  alias Fitstr.Activities
  alias Fitstr.Activities.Movement

  def index(conn, _params) do
    movements = Activities.list_movements()
    render(conn, "index.html", movements: movements)
  end

  def new(conn, _params) do
    changeset = Activities.change_movement(%Movement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movement" => movement_params}) do
    case Activities.create_movement(movement_params) do
      {:ok, movement} ->
        conn
        |> put_flash(:info, "Movement created successfully.")
        |> redirect(to: movement_path(conn, :show, movement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movement = Activities.get_movement!(id)
    render(conn, "show.html", movement: movement)
  end

  def edit(conn, %{"id" => id}) do
    movement = Activities.get_movement!(id)
    changeset = Activities.change_movement(movement)
    render(conn, "edit.html", movement: movement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Activities.get_movement!(id)

    case Activities.update_movement(movement, movement_params) do
      {:ok, movement} ->
        conn
        |> put_flash(:info, "Movement updated successfully.")
        |> redirect(to: movement_path(conn, :show, movement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movement: movement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Activities.get_movement!(id)
    {:ok, _movement} = Activities.delete_movement(movement)

    conn
    |> put_flash(:info, "Movement deleted successfully.")
    |> redirect(to: movement_path(conn, :index))
  end
end
