defmodule FitstrWeb.Journals.MovementController do
  use FitstrWeb, :controller

  alias Fitstr.Journals
  alias Fitstr.Journals.Movement

  def index(conn, _params) do
    journal_movements = Journals.list_journal_movements()
    render(conn, "index.html", journal_movements: journal_movements)
  end

  def new(conn, _params) do
    changeset = Journals.change_movement(%Movement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movement" => movement_params}) do
    case Journals.create_movement(movement_params) do
      {:ok, movement} ->
        conn
        |> put_flash(:info, "Movement created successfully.")
        |> redirect(to: journals_movement_path(conn, :show, movement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movement = Journals.get_movement!(id)
    render(conn, "show.html", movement: movement)
  end

  def edit(conn, %{"id" => id}) do
    movement = Journals.get_movement!(id)
    changeset = Journals.change_movement(movement)
    render(conn, "edit.html", movement: movement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Journals.get_movement!(id)

    case Journals.update_movement(movement, movement_params) do
      {:ok, movement} ->
        conn
        |> put_flash(:info, "Movement updated successfully.")
        |> redirect(to: journals_movement_path(conn, :show, movement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movement: movement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Journals.get_movement!(id)
    {:ok, _movement} = Journals.delete_movement(movement)

    conn
    |> put_flash(:info, "Movement deleted successfully.")
    |> redirect(to: journals_movement_path(conn, :index))
  end
end
