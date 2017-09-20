defmodule FitstrWeb.Plugs.Auth do
  @moduledoc """
  A plug for working with web browser authentication.
  """

  import Plug.Conn
  alias Fitstr.Accounts
  alias Fitstr.Repo

  @doc """
  Initialize
  """
  @spec init(Any.t) :: Any.t
  def init(params), do: params

  @doc """
  A callback function when invoking as a plug in a pipeline.
  It checks if the connection is authenticated and either let through, or
  redirect to the log-in page.
  """
  @spec call(%Plug.Conn{}, Any.t) :: %Plug.Conn{}
  def call(conn, _params) do
    conn
    |> signed_in?
    |> case do
      {:ok, user} -> conn |> assign(:current_user, user)
      _ ->
        conn
        |> Phoenix.Controller.redirect(to: FitstrWeb.Router.Helpers.auth_path(conn, :request, "google"))
        |> halt
    end
  end

  @doc """
  A helper function for signing in a given user.
  """
  @spec sign_in(%Plug.Conn{}, %Accounts.User{}) :: %Plug.Conn{}
  def sign_in(conn, user) do
    conn
    |> put_session(:current_user, user)
    |> assign(:current_user, user)
  end

  @doc """
  A helper function for signing out user's session
  """
  @spec sign_out(%Plug.Conn{}) :: %Plug.Conn{}
  def sign_out(conn) do
    conn
    |> assign(:current_user, nil)
    |> clear_session
    |> configure_session(drop: true)
  end

  @doc """
  Check if the given connection is authenticated.
  """
  @spec signed_in?(%Plug.Conn{}) :: {:ok, %Accounts.User{}} | :error
  def signed_in?(conn) do
    conn
    |> get_session(:current_user)
    |> case do
      nil -> :error
      user -> {:ok, user}
    end
  end
end
