defmodule MyApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :text, :string
      add :complete, :boolean, default: false, null: false

      timestamps()
    end

  end
end
