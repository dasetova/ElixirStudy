defmodule HelloWeb.Router do
  use HelloWeb, :router

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

  scope "/", HelloWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index #Usado para procesar un request
    get "/hello", HelloController, :index #Nueva línea, operación "url", "Controlador", ":accion"
    get "/hello/:messenger", HelloController, :show #En este caso se recibe un parámetro
    resources "/owners", OwnerController do
      resources "/vehicles", VehicleController
    end
  end

  #El as agrega el atom como inicio de path_helper
  #Definir el HelloWeb.Admin reduce el controlador en cadal línea de resources
  #o de ruta independiente
  scope "/admin", HelloWeb.Admin,as: :admin do
    pipe_through :browser
    #resources "/reviews", HelloWeb.Admin.ReviewController
    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  scope "/api", HelloWeb do
    pipe_through :api
    resources "/reviews", ReviewController
  end

  scope "/test", HelloWeb do
    pipe_through [:browser, :api] #De esta manera sera usado por ambos pipelines en orden.
    resources "/users", ReviewController
  end
end
