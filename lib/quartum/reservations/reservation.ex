defmodule Quartum.Reservations.Reservation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quartum.Reservations
  alias Quartum.Guests

  schema "reservations" do
    field :checkin_time, :naive_datetime
    field :checkout_time, :naive_datetime
    field :guest_count, :integer
    field :number, :integer
    field :status, :string

    belongs_to :room, Reservations.Room
    belongs_to :guest, Guests.Guest, foreign_key: :main_guest_id

    has_one :payment, Reservations.Payment
    many_to_many :companions, Guests.Guest, join_through: "companions"

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    IO.inspect(attrs)
    reservation
    |> cast(attrs, [:checkin_time, :checkout_time, :status, :number, :guest_count, :room_id, :main_guest_id])
    |> validate_required([:checkin_time, :checkout_time, :status, :number, :guest_count, :room_id, :main_guest_id])
    |> cast_assoc(:payment)
    |> PhoenixMTM.Changeset.cast_collection(:companions, &Reservations.get_companions!(&1))
  end
end
