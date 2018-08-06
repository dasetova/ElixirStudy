defmodule Hello2Web.PageController do
  use Hello2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
