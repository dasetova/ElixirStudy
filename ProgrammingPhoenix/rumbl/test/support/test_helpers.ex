defmodule Rumbl.TestHelpers do
  alias Rumbl.Repo
  alias Rumbl.Models.{User}

  def insert_user(attrs \\ %{}) do
    # Se reemplaza el Dict que mostraba deprecated
    changes =
      Map.merge(
        %{
          name: "Some user",
          # Se reemplaza rand_bytes que fue reemplazado
          username: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}",
          password: "supersecret"
        },
        attrs
      )

    %User{}
    |> User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_video(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:videos, attrs)
    |> Repo.insert!()
  end
end
