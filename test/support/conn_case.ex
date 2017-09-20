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

  alias Fitstr.Accounts

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import FitstrWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint FitstrWeb.Endpoint

      def init_session(conn), do: FitstrWeb.ConnCase.init_session()
      def sign_in(conn, user \\ %Fitstr.Accounts.User{}) do
        conn
        |> init_session
        |> FitstrWeb.Plugs.Auth.sign_in(user)
      end

      defoverridable [ init_session: 1, sign_in: 2 ]
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Fitstr.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Fitstr.Repo, {:shared, self()})
    end

    guest = Phoenix.ConnTest.build_conn()
    |> FitstrWeb.ConnCase.init_session
    conn = guest
    |> FitstrWeb.Plugs.Auth.sign_in(%Accounts.User{})
    {:ok, conn: conn, guest: guest}
  end

  @doc """
  """
  @spec init_session() :: %Plug.Conn{}
  @spec init_session(%Plug.Conn{}) :: %Plug.Conn{}
  def init_session(), do: Phoenix.ConnTest.build_conn() |> init_session
  def init_session(%Plug.Conn{} = conn) do
    opts = Plug.Session.init(
      store: :cookie,
      key: "foobar",
      encryption_salt: "encrypted cookie salt",
      signing_salt: "signing salt",
      log: false,
      encrypt: false
    )

    conn
    |> Plug.Session.call(opts)
    |> Plug.Conn.fetch_session()
  end
end
