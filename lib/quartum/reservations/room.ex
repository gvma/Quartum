defmodule Quartum.Reservations.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quartum.Reservations

  schema "rooms" do
    field :air_conditioner, :boolean, default: false
    field :bathrooms, :integer
    field :capacity, :integer
    field :double_beds, :integer
    field :microwave, :boolean, default: false
    field :minibar, :boolean, default: false
    field :single_beds, :integer
    field :size, :string
    field :tv, :boolean, default: false
    field :habitational_unit, :integer

    has_many :reservations, Reservations.Reservation

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:size, :capacity, :bathrooms, :single_beds, :double_beds, :minibar,
     :microwave, :tv, :air_conditioner, :habitational_unit])
    |> validate_required([:size, :capacity, :bathrooms, :single_beds, :double_beds, :minibar,
     :microwave, :tv, :air_conditioner, :habitational_unit])
  end
end
