defmodule Rumbl.Repo.Migrations.AddCategoryIdToVideo do
  use Ecto.Migration

  def change do
    #Alterar la tabla de videos
    alter table(:videos) do
      add :category_id, references(:categories) #Para agregar el nuevo category_id
    end
  end
end
