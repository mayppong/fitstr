defmodule FitstrWeb.AuthController do
  use FitstrWeb, :controller
  plug Ueberauth

  alias Fitstr.Accounts

  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    Accounts.get_user_by(email: auth.info.email)
    |> case do
      nil -> Accounts.create_user(%{email: auth.info.email})
      user -> {:ok, user}
    end
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Thank you for signing in!")
        |> put_session(:current_user, user)
        |> redirect(to: page_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: page_path(conn, :index))
    end
  end
end
