defmodule RumblWeb.VideoController do
  use RumblWeb, :controller

  alias Rumbl.Models
  #Se agrega un plug para agregar categories en las acciones definidas
  plug :load_categories when action in [:new, :create, :edit, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, user) do
    videos = Models.list_user_videos(user)#list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params, user) do
    changeset = Models.change_video_user(user)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, user) do
    case Models.create_video(video_params, user) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    video = Models.get_user_video!(user, id)#get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}, user) do
    video = Models.get_user_video!(user, id)
    changeset = Models.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, user) do
    video = Models.get_user_video!(user, id)

    case Models.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    video = Models.get_user_video!(user, id)
    {:ok, _video} = Models.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end

  defp load_categories(conn, _) do
    categories = Models.load_categories()
    assign(conn, :categories, categories)
  end
end
