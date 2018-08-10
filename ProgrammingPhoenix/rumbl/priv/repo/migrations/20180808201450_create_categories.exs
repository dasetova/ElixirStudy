defmodule Rumbl.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string

      timestamps()
    end
    #Crearla como unica
    create unique_index(:categories, [:name])
  end
end
