defmodule Rumbl.Models.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Models.User


  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    #field :user_id, :id
    belongs_to :user, User #Relaciona con el schema User

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
  end

end
