defmodule RumblWeb.UserController do
    use RumblWeb, :controller
    alias Rumbl.Models.User
    alias Rumbl.Repo

    def index(conn, _params) do
        users = Repo.all(User)
        render conn, "index.html", users: users
    end

    def show(conn, %{"id" => id}) do
        user = Repo.get(User, id)
        render conn, "show.html", user: user
    end

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render conn, "new.html", changeset: changeset #Cuando se renderiza desde el create, el changeset va con la accion de insert por lo que es un error generado
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.changeset(%User{}, user_params) #Nuevo changeset con los parametreos recibidos del form
        case Repo.insert(changeset) do
            {:ok, user} -> #si es existoso se recibe este mapa
                conn
                |> put_flash(:info, "#{user.name} created!")
                |> redirect(to: user_path(conn, :index))
            {:error, changeset} -> #si existe algun error el atom seria :error
                render(conn, "new.html", changeset: changeset) #Cuando se renderiza desde el new, el changeset no tiene ninguna acción
        end
    end
end