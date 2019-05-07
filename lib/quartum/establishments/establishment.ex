defmodule Quartum.Establishments.Establishment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "establishments" do
    field :name, :string
    field :specifications, :string

    timestamps()
  end

  @doc false
  def changeset(establishment, attrs) do
    establishment
    |> cast(attrs, [:name, :specifications])
    |> validate_required([:name, :specifications])
  end
end
