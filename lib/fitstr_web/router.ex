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
    pipe_through [:browser, FitstrWeb.Plugs.Auth]

    get "/auth/signout", AuthController, :delete
    resources "/users", UserController

    scope "/activities", Activities, as: :activities do
      scope "/exercises", Exercises, as: :exercises do
        resources "/movements", MovementController
        resources "/workouts", WorkoutController
      end
    end
    scope "/journals", Journals, as: :journals do
      resources "/movements", MovementController
      resources "/workouts", WorkoutController
    end
  end

  scope "/api/v1", FitstrWeb.API.V1, as: :api_v1 do
    pipe_through :api

    scope "/activities", Activities, as: :activities do
      scope "/exercises", Exercises, as: :exercises do
        resources "/movements", MovementController
        resources "/workouts", WorkoutController
      end
    end

    scope "/journals", Journals, as: :journals do
      resources "/workouts", WorkoutController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", FitstrWeb do
  #   pipe_through :api
  # end
end
