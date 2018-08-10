defmodule Rumbl.Models.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Models.User
  alias Rumbl.Models.Category


  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    #field :user_id, :id
    belongs_to :user, User #Relaciona con el schema User
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description])
    |> validate_required([:url, :title, :description]) #Lo que no está aquí no es requerido
    |> assoc_constraint(:category) #Muestra el error de manera de validación en el front en vez de mostrar una excepción
  end

end
