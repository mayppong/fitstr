defmodule FitstrWeb.Template.Layout.AppTest do
  use FitstrWeb.ConnCase, async: true

  test "shows sign in button when not signed in", %{guest: guest} do
    conn = get guest, "/"
    assert html_response(conn, 200) =~ "Sign in"
  end

  test "shows sign out button when signed in", %{conn: conn} do
    conn = conn
    |> get("/")

    assert html_response(conn, 200) =~ "Sign out"
  end
end
