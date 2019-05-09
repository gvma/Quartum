defmodule Quartum.Guests.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quartum.Guests

  schema "addresses" do
    field :city, :string
    field :country, :string
    field :neighborhood, :string
    field :state, :string
    field :street, :string
    field :street_number, :string
    field :zip_code, :string

    belongs_to :guest, Guests.Guest

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:country, :city, :state, :street, :street_number, :neighborhood, :zip_code, :guest_id])
    |> validate_required([:country, :city, :state, :street, :street_number, :neighborhood, :zip_code])
    |> assoc_constraint(:guest)
  end
end
