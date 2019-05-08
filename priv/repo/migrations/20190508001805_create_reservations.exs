defmodule Quartum.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :checkin_time, :naive_datetime
      add :checkout_time, :naive_datetime
      add :status, :string
      add :number, :integer
      add :guest_count, :integer
      add :room_id, references(:rooms, on_delete: :nothing)
      add :main_guest_id, references(:guests, on_delete: :nothing)

      timestamps()
    end

    create index(:reservations, [:room_id])
    create index(:reservations, [:main_guest_id])
  end
end
