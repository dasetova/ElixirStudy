defmodule RumblWeb.UserController do
    use RumblWeb, :controller
    alias Rumbl.Models.User
    alias Rumbl.Repo

    # Involucra el plug dentro de las acciones index y show
    # Esto hace que primero se invoque el plug y si todo funciona 
    # Correctamente si realizan las acciones
    plug :authenticate_user when action in [:index, :show]

    def index(conn, _params) do
        #Esta sería la implementación si no se usa la funcion authenticate como un plug sino como una funcion normal
        #case authenticate(conn) do #Se llama la funcion privada
        #    %Plug.Conn{halted: true} = conn -> #En caso que se haya seteado la bandera
        #        conn #Se devuelve
        #    conn -> #En caso que si existiera un usuario loggeado
        #        users = Repo.all(User) #Se realiza la consulta
        #        render conn, "index.html", users: users
        #end
        users = Repo.all(User) #Se realiza la consulta
        render conn, "index.html", users: users
    end

    def show(conn, %{"id" => id}) do
        user = Repo.get(User, id)
        render conn, "show.html", user: user
    end

    def new(conn, _params) do
        changeset = User.changeset(%User{}, %{})
        render conn, "new.html", changeset: changeset #Cuando se renderiza desde el create, el changeset va con la accion de insert por lo que es un error generado
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.registration_changeset(%User{}, user_params) #Usando el changeset con la contraseña encriptada
        case Repo.insert(changeset) do
            {:ok, user} -> #si es exitoso se recibe este mapa
                conn
                |> Rumbl.Auth.login(user)
                |> put_flash(:info, "#{user.name} created!")
                |> redirect(to: user_path(conn, :index))
            {:error, changeset} -> #si existe algun error el atom seria :error
                render(conn, "new.html", changeset: changeset) #Cuando se renderiza desde el new, el changeset no tiene ninguna acción
        end
    end


    
end