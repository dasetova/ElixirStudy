# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hello2,
  ecto_repos: [Hello2.Repo]

# Configures the endpoint
config :hello2, Hello2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RIReAIh8gVaF//Mz0HSZTbRh1PlCMVTAlcmIWCSuvlq1vgG/SNOeeuwbTjS89bWC",
  render_errors: [view: Hello2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hello2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
