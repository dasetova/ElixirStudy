defmodule Rumbl.Models.User do
    use Ecto.Schema #En el libro se ve como use Rumbl.Web, :model
    import Ecto.Changeset
    alias Rumbl.Models.User

    schema "users" do
        field :name, :string
        field :username, :string
        field :password, :string, virtual: true
        field :password_hash, :string
        timestamps() #Campos de inserted_at y updated_at
    end

    @doc """
    La función changeset es necesaria para validar la data y realizar cambios
    con este schema
    """
    def changeset(%User{} = user, params \\ :empty) do
        user
        |> cast(params, [:name,:username]) #Es necesario el import Ecto.Changeset
        |> validate_length(:username, min: 1, max: 20)
    end
end