defmodule FitstrWeb.Router do
  use FitstrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # public pages
  scope "/", FitstrWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/auth" do
      pipe_through :browser

      get "/signout", AuthController, :delete
      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :new
    end
  end

  # users only pages
  scope "/", FitstrWeb do
    pipe_through [:browser]

    get "/auth/signout", AuthController, :delete
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FitstrWeb do
  #   pipe_through :api
  # end
end
