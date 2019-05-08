defmodule Quartum.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :size, :string
      add :capacity, :integer
      add :bathrooms, :integer
      add :single_beds, :integer
      add :double_beds, :integer
      add :minibar, :boolean, default: false, null: false
      add :microwave, :boolean, default: false, null: false
      add :tv, :boolean, default: false, null: false
      add :air_conditioner, :boolean, default: false, null: false
      add :habitational_unit, :integer

      timestamps()
    end

  end
end
