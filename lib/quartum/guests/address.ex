defmodule Quartum.Guests.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guests.Guest
  
  schema "addresses" do
    field :city, :string
    field :country, :string
    field :neighborhood, :string
    field :state, :string
    field :street, :string
    field :street_number, :string
    field :zip_code, :string

    has_one :guest, Guest

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:country, :city, :state, :street, :street_number, :neighborhood, :zip_code])
    |> validate_required([:country, :city, :state, :street, :street_number, :neighborhood, :zip_code])
  end
end