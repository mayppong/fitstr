defmodule FitstrWeb.AuthController do
  use FitstrWeb, :controller
  plug Ueberauth

  alias Fitstr.Accounts

  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    [email: auth.info.email]
    |> Accounts.get_user_by()
    |> case do
      nil -> Accounts.create_user(%{email: auth.info.email})
      user -> {:ok, user}
    end
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Thank you for signing in!")
        |> FitstrWeb.Plugs.Auth.sign_in(user)
        |> redirect(to: page_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :index))
  end
end
