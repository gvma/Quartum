defmodule Quartum.Reservations.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :checkin_time, :naive_datetime
    field :checkout_time, :naive_datetime
    field :guest_count, :integer
    field :number, :integer
    field :status, :string

    belongs_to :room, Reservations.Room
    belongs_to :guest, Guests.Guest, foreign_key: :main_guest_id
    belongs_to :payment, Reservations.Payment

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:checkin_time, :checkout_time, :status, :number, :guest_count, :room_id, :main_guest_id, :payment_id])
    |> validate_required([:checkin_time, :checkout_time, :status, :number, :guest_count])
    #, :room_id, :main_guest_id, :payment_id
  end
end
