defmodule FitstrWeb.Plugs.AuthTest do
  use FitstrWeb.ConnCase
  alias FitstrWeb.Plugs.Auth
  alias Fitstr.Accounts

  test "redirect to login page if not signed in", %{guest: guest} do
    redirect = guest
    |> Auth.call(%{})
    |> redirected_to

    assert redirect == FitstrWeb.Router.Helpers.auth_path(guest, :request, "google")
  end

  test "no redirect to login page if signed in", %{conn: conn} do
    conn = conn
    |> assign(:current_user, %Accounts.User{})
    |> Auth.call(%{})

    assert conn.status != 302
  end
end
