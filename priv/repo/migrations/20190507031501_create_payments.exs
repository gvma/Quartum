defmodule Quartum.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :total_payment, :money_with_currency
      add :partial_payment, :money_with_currency
      add :category, :string
      add :payment_method, :string
      add :obs, :text

      timestamps()
    end

  end
end
