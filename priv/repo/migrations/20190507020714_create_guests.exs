defmodule Quartum.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :full_name, :string
      add :age, :integer
      add :photo, :string
      add :rg, :string
      add :cpf, :string
      add :primary_phone, :string
      add :secondary_phone, :string
      add :email, :string
      add :birthdate, :date
      add :gender, :boolean, default: false, null: false

      timestamps()
    end
  end
end
