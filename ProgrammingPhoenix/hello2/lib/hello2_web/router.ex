defmodule Hello2Web.Router do
  use Hello2Web, :router

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

  #Todas las URL que esten dentro de / como localhost:4000/
  scope "/", Hello2Web do
    pipe_through :browser # Use the default browser stack

    get "/hello/:name", HelloController, :world #Paso de un parámetro por URL
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Hello2Web do
  #   pipe_through :api
  # end
end
