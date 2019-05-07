defmodule Quartum.Reservations.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :total_payment, Money.Ecto.Composite.Type
    field :partial_payment, Money.Ecto.Composite.Type
    field :category, :string
    field :obs, :string
    field :payment_method, :string

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    attrs = update_attrs(attrs)

    payment
    |> cast(attrs, [:total_payment, :partial_payment, :category, :payment_method, :obs])
    |> validate_required([:total_payment, :partial_payment, :category, :payment_method, :obs])
  end

  defp update_attrs(attrs) do
    attrs =
    if Map.has_key?(attrs, "total_payment") do
      Map.update!(attrs, "total_payment", &convert_to_money/1)
    else
      attrs
    end

    attrs =
    if Map.has_key?(attrs, "partial_payment") do
      Map.update!(attrs, "partial_payment", &convert_to_money/1)
    else
      attrs
    end
  end

  defp convert_to_money(amount) when is_binary(amount) do
    amount = String.replace_prefix(amount, "R$", "")

    amount =
    if not String.contains?(amount, ".") do
      amount <> "00"
    else
      amount
    end

    amount = String.replace(amount, ".", "")
    convert_to_money(String.to_integer(amount))
  end

  defp convert_to_money(amount) do
    Money.new(amount, :BRL)
  end
end
