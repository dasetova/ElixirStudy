defmodule Hello2Web.HelloController do
    use Hello2Web, :controller

    def world(conn, %{"name" => name}) do #Los parametros son recibios como un mapa, por lo que se hace es extraer la informacion del parametro name y pasarlo a la variable name
        #Envia a la vista la plantilla para renderizar
        #Se envía un parámetro hacia la vista como respuesta
        render conn, "world.html", name: name 
    end
end