defmodule Quartum.Repo.Migrations.CreateCompanions do
  use Ecto.Migration

  def change do
    create table(:companions, primary_key: false) do
      add :guest_id, references(:guests, on_delete: :nothing)
      add :reservation_id, references(:reservations, on_delete: :nothing)

    end
    # TODO: TALVEZ SEJA BOM BOTAR ISSO GABRIEL
    # create index(:guests, [:guest_id])
    # create index(:reservations, [:reservation_id])
  end
end
