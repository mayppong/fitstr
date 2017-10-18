defmodule FitstrWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  alias Phoenix.ConnTest
  alias Fitstr.Accounts

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import FitstrWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint FitstrWeb.Endpoint

      @doc """
      A helper function for initializing a given test connection through the
      app's endpoint plugs.
      """
      @spec through_endpoint(%Plug.Conn{}) :: %Plug.Conn{}
      def through_endpoint(conn), do: conn |> FitstrWeb.ConnCase.through_endpoint()

      @doc """
      A helper function for authenticating a given test connection with the
      specified user.
      """
      @spec sign_in(%Plug.Conn{}, %Fitstr.Accounts.User{}) :: %Plug.Conn{}
      def sign_in(conn, user \\ %Fitstr.Accounts.User{}) do
        conn
        |> through_endpoint
        |> FitstrWeb.ConnCase.sign_in(user)
      end

      defoverridable [ through_endpoint: 1, sign_in: 2 ]
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Fitstr.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Fitstr.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()
    guest = conn
    |> through_endpoint
    auth = guest
    |> sign_in
    {:ok, conn: conn, browser: %{auth: auth, guest: guest}}
  end

  @doc """
  Push given connection through app's endpoint to invoke the plugs defined.
  """
  @spec through_endpoint() :: %Plug.Conn{}
  @spec through_endpoint(%Plug.Conn{}) :: %Plug.Conn{}
  def through_endpoint(), do: ConnTest.build_conn() |> through_endpoint
  def through_endpoint(conn) do
    conn
    |> ConnTest.bypass_through()
    |> ConnTest.dispatch(FitstrWeb.Endpoint, "get", "/")
    |> Plug.Conn.fetch_session()
  end

  @doc """
  Authenticate a given connection with a given user.
  If no user is given, make a new user
  """
  @spec sign_in(%Plug.Conn{}) :: %Plug.Conn{}
  def sign_in(conn, user \\ %Accounts.User{}) do
    conn
    |> FitstrWeb.Plugs.Auth.sign_in(user)
    |> recycle
    |> ConnTest.dispatch(FitstrWeb.Endpoint, "get", "/")
  end

  # A helper function for recycling a connection that went through an
  # authentication process.
  defp recycle(conn) do
    conn
    |> Plug.Conn.send_resp(:ok, "")
    |> ConnTest.recycle
  end
end
