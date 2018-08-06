defmodule Hello.HelloController do
    use Hello.Web, :controller #Esto define este modulo como un controlador de phoenix
    

    def world(conn, _params) do #El parámetro _params el opcional
        render conn, "world.html" #Envia a la vista la plantilla para renderizar
    end

end