#El nombre del modulo incluye el namespace
defmodule HelloWeb.HelloController do
    @moduledoc """
    Modulo creado como explicación de una nueva página con dos acciones para procesamiento
    """
    use HelloWeb, :controller
    @doc """
    conn contiene información sobre el request
    _params es para recibir los parámetros enviados, el _ lo hace opcional
    """
    def index(conn, _params) do
        render conn, "index.html" #En realidad, la template se llamará index.html.eex
    end

    def show(conn, %{"messenger" => messenger}) do
        render conn, "show.html", messenger: messenger
    end


end