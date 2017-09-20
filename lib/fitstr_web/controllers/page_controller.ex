defmodule FitstrWeb.PageController do
  use FitstrWeb, :controller

  def index(conn, _params) do
    conn = conn
    |> get_session(:current_user)
    |> case do
      nil -> conn
      user -> conn |> assign(:current_user, user)
    end

    render conn, "index.html"
  end
end
