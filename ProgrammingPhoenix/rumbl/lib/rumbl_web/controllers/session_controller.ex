defmodule RumblWeb.SessionController do
    use RumblWeb, :controller
    alias Rumbl.Repo

    def new(conn, _) do
        render conn, "new.html"
    end

    def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
        case Rumbl.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
            {:ok, conn} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> redirect(to: page_path(conn, :index))
            {:error, _reason, conn} ->
                conn
                |> put_flash(:error, "Invalid username/password combination")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        conn
        |> Rumbl.Auth.logout() #Eliminar la sesion
        |> redirect(to: page_path(conn, :index)) #Enviar al index de la página
    end
end