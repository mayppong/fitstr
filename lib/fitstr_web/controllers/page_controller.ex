defmodule FitstrWeb.PageController do
  use FitstrWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
