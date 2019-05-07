defmodule Quartum.ReservationsTest do
  use Quartum.DataCase

  alias Quartum.Reservations

  describe "payments" do
    alias Quartum.Reservations.Payment

    @valid_attrs %{category: "some category", obs: "some obs", payment_method: "some payment_method"}
    @update_attrs %{category: "some updated category", obs: "some updated obs", payment_method: "some updated payment_method"}
    @invalid_attrs %{category: nil, obs: nil, payment_method: nil}

    def payment_fixture(attrs \\ %{}) do
      {:ok, payment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reservations.create_payment()

      payment
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Reservations.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Reservations.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      assert {:ok, %Payment{} = payment} = Reservations.create_payment(@valid_attrs)
      assert payment.category == "some category"
      assert payment.obs == "some obs"
      assert payment.payment_method == "some payment_method"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservations.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{} = payment} = Reservations.update_payment(payment, @update_attrs)
      assert payment.category == "some updated category"
      assert payment.obs == "some updated obs"
      assert payment.payment_method == "some updated payment_method"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservations.update_payment(payment, @invalid_attrs)
      assert payment == Reservations.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Reservations.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Reservations.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Reservations.change_payment(payment)
    end
  end
end
