# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fitstr,
  ecto_repos: [Fitstr.Repo]

# Configures the endpoint
config :fitstr, FitstrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PJRmj2qoEaDaQV+GD/C8gaWojB4XLMpFCtC3KJGyTXXwi07P2Xjofg/tV2l3zHib",
  render_errors: [view: FitstrWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fitstr.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
