defmodule Quartum.Repo.Migrations.CreateEstablishments do
  use Ecto.Migration

  def change do
    create table(:establishments) do
      add :name, :string
      add :specifications, :text

      timestamps()
    end

  end
end
