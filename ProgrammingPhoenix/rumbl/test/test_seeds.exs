# alias Rumbl.Repo
# alias Rumbl.Models.Category
# alias Rumbl.Models.User

## Insercion de Usuarios
#
# Repo.insert!(
#  User.registration_changeset(%User{}, %{
#    "name" => "user1",
#    "password" => "test123",
#    "username" => "anon1"
#  })
# )
#
# Repo.insert!(
#  User.registration_changeset(%User{}, %{
#    "name" => "user2",
#    "password" => "test123",
#    "username" => "anon2"
#  })
# )
#
# Repo.insert!(
#  User.registration_changeset(%User{}, %{
#    "name" => "user3",
#    "password" => "test123",
#    "username" => "anon3"
#  })
# )
#
## Insercion de categorias
# for category <- ~w(Action Drama Romance Comedy Sci-fi) do
#  Repo.insert!(%Category{name: category})
# end
#
