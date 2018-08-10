defmodule Rumbl.Models.User do
    use Ecto.Schema #En el libro se ve como use Rumbl.Web, :model
    import Ecto.Changeset
    #alias Rumbl.Models.User

    schema "users" do
        field :name, :string
        field :username, :string
        field :password, :string, virtual: true
        field :password_hash, :string
        has_many :videos, Rumbl.Models.Video

        timestamps() #Campos de inserted_at y updated_at
    end

    @doc """
    La función changeset es necesaria para validar la data y realizar cambios
    con este schema
    """
    def changeset(model, params) do
        model
        |> cast(params, ~w(name username), []) #Es necesario el import Ecto.Changeset
        |> validate_length(:username, min: 1, max: 20)
        |> unique_constraint(:username) #Agrega el manejo de errores del Unique, para que no se estalle la app sino que muestra una validación más en el front
    end

    def registration_changeset(model, params) do
        model
        |> changeset(params)
        |> cast(params, ~w(password), []) #Valida que traiga la contraseña
        |> validate_length(:password, min: 6, max: 100)
        |> put_pass_hash()
    end

    defp put_pass_hash(changeset) do
        case changeset do
            %Ecto.Changeset{valid?: true, changes: %{password: pass}} -> #valida que el changeset sea valido
                put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass)) #Si es valido, entonces se realiza la insercion de la contraseña
            _ -> changeset
        end
    end
end
