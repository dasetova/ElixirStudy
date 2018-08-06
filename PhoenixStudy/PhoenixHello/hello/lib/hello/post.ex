defmodule Hello.Post do
    use Ecto.Schema

    schema "posts" do
        field :header, :string
        field :body, :string
        belongs_to :user, Hello.User 
    end
end