defmodule FitstrWeb.AuthController do
  use FitstrWeb, :controller
  plug Ueberauth

  alias Fitstr.Accounts
end
