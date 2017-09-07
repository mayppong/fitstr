defmodule FitstrWeb.Template.Layout.AppTest do
  use FitstrWeb.ConnCase, async: true

  alias Fitstr.Accounts

  test "shows sign in button when not signed in", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Sign in"
  end

  test "shows sign out button when signed in", %{conn: conn} do
    user = %{email: "tester@example.com"}
    |> Accounts.create_user

    conn = conn
    |> assign(:current_user, user)
    |> get("/")

    assert html_response(conn, 200) =~ "Sign out"
  end
end
