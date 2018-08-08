defmodule Rumbl.Auth do
    import Plug.Conn
    
    def init(opts) do
        Keyword.fetch!(opts, :repo) #Obtiene el repositorio
    end

    def call(conn, repo) do
        user_id = get_session(conn, :user_id) #Verifica si hay un usuario guardado en session
        user = user_id && repo.get(Rumbl.Models.User, user_id) #Se obtiene el usuario
        assign(conn, :current_user, user) #Se guarda en el conn, assign es una funcion de Plug.Conn
    end
end