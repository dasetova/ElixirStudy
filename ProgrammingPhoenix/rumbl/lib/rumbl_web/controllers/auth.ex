defmodule Rumbl.Auth do
    import Plug.Conn
    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
    
    def init(opts) do
        Keyword.fetch!(opts, :repo) #Obtiene el repositorio
    end

    def call(conn, repo) do
        user_id = get_session(conn, :user_id) #Verifica si hay un usuario guardado en session
        user = user_id && repo.get(Rumbl.Models.User, user_id) #Se obtiene el usuario
        assign(conn, :current_user, user) #Se guarda en el conn, assign es una funcion de Plug.Conn
    end

    def login(conn, user) do
        conn
        |> assign(:current_user, user) #Agrega en el campo de assign el usuario
        |> put_session(:user_id, user.id) #Agrega el parámetro que es consultado en el call
        |> configure_session(renew: true) #Esto hace que se refresque la sesion por si había otra sesión ya iniciada
    end

    def login_by_username_and_pass(conn, username, given_pass, opts) do
        repo =  Keyword.fetch!(opts, :repo) #Obtiene el repo que se paso como parámetro
        user = repo.get_by(Rumbl.Models.User, username: username) #Obtiene el usuario de bd según el username

        cond do
            user && checkpw(given_pass, user.password_hash) -> #Evalúa la contraseña recibida vs. la guardada como hash
                {:ok, login(conn, user)} #Correcto
            user ->
                {:error, :unauthorized, conn} #Se encontró usuario pero la contraseña no corresponde
            true -> #No se encontró usuario
                dummy_checkpw() #Mantiene la aplicación segura cuando no se encuentra el usuario
                {:error, :not_found, conn}
        end

    end

    def logout(conn) do
        configure_session(conn, drop: true) #Elimina la sesion del conn
    end
end