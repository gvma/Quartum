defmodule Quartum.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guests.Address

  schema "guests" do
    field :age, :integer
    field :birthdate, :date
    field :cpf, :string
    field :email, :string
    field :full_name, :string
    field :gender, :boolean, default: false
    field :photo, :string
    field :primary_phone, :string
    field :rg, :string
    field :secondary_phone, :string

    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:full_name, :age, :photo, :rg, :cpf, :primary_phone, :secondary_phone, :email, :birthdate, :gender])
    |> validate_required([:full_name, :age, :photo, :rg, :cpf, :primary_phone, :secondary_phone, :email, :birthdate, :gender])
  end
end
