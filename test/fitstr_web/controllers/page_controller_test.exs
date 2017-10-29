defmodule FitstrWeb.PageControllerTest do
  use FitstrWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Fitstr!"
  end
end
