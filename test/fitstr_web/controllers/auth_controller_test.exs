defmodule FitstrWeb.AuthControllerTest do
  use FitstrWeb.ConnCase
  alias Fitstr.Accounts

  @ueberauth_auth %{credentials: %{token: "fdsnoafhnoofh08h38h"},
    info: %{email: "tester@example.com", handler: "tester"},
    provider: :google}

  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google?scope=email%20profile"
    assert redirected_to(conn, 302)
  end

  # Not sure how to format Google's response to test for this?
  # Skipping for now.
  @tag :skip
  test "creates user from Google information", %{conn: conn} do
    conn = conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
    |> get(FitstrWeb.Router.Helpers.auth_path(conn, :new, "google"), %{
      "code" => "abc",
      "client_id" => "abc",
      "client_secret" => "abc",
      "redirect_uri" => "/auth/google/callback",
      "grant_type" => "authorization_code"
    })

    users = Accounts.list_users
    assert Enum.count(users) == 1
    assert get_flash(conn, :info) == "Thank you for signing in!"
  end

  test "signs user out of the application", %{conn: conn} do
    user = %{email: "tester@example.com"}
    |> Accounts.create_user

    conn = conn
    |> assign(:current_user, user)
    |> get("/auth/signout")
    |> get("/")

    assert Map.get(conn.assigns, :current_user, nil) == nil
  end
end
