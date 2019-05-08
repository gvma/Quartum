defmodule Quartum.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :total_payment, :money_with_currency
      add :partial_payment, :money_with_currency
      add :category, :string
      add :payment_method, :string
      add :obs, :text
      add :reservation_id, references(:reservations, on_delete: :nothing)

      timestamps()
    end

    create index(:payments, [:reservation_id])
  end
end
