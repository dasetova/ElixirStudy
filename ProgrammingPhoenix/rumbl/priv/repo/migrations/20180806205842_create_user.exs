defmodule Rumbl.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    #Creacion de una tabla
    create table(:users) do
      add :name, :string
      add :username, :string, null: false
      add :password_hash, :string
      timestamps
    end

    #Creacion de llave unica para username
    create unique_index(:users, [:username])
  end
end
