defmodule Quartum.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :country, :string
      add :city, :string
      add :state, :string
      add :street, :string
      add :street_number, :string
      add :neighborhood, :string
      add :zip_code, :string
      add :guest_id, references(:guests, on_delete: :nothing)

      timestamps()
    end

    create index(:addresses, [:guest_id])
  end
end
