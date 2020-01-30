defmodule MyApp.Todos.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :complete, :boolean, default: false
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:text, :complete])
    |> validate_required([:text, :complete])
  end
end
