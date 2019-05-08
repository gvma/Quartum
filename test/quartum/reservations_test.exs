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

  describe "rooms" do
    alias Quartum.Reservations.Room

    @valid_attrs %{air_conditioner: true, bathrooms: 42, capacity: 42, double_beds: 42, microwave: true, minibar: true, single_beds: 42, size: "some size", tv: true}
    @update_attrs %{air_conditioner: false, bathrooms: 43, capacity: 43, double_beds: 43, microwave: false, minibar: false, single_beds: 43, size: "some updated size", tv: false}
    @invalid_attrs %{air_conditioner: nil, bathrooms: nil, capacity: nil, double_beds: nil, microwave: nil, minibar: nil, single_beds: nil, size: nil, tv: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reservations.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Reservations.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Reservations.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Reservations.create_room(@valid_attrs)
      assert room.air_conditioner == true
      assert room.bathrooms == 42
      assert room.capacity == 42
      assert room.double_beds == 42
      assert room.microwave == true
      assert room.minibar == true
      assert room.single_beds == 42
      assert room.size == "some size"
      assert room.tv == true
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservations.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Reservations.update_room(room, @update_attrs)
      assert room.air_conditioner == false
      assert room.bathrooms == 43
      assert room.capacity == 43
      assert room.double_beds == 43
      assert room.microwave == false
      assert room.minibar == false
      assert room.single_beds == 43
      assert room.size == "some updated size"
      assert room.tv == false
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservations.update_room(room, @invalid_attrs)
      assert room == Reservations.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Reservations.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Reservations.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Reservations.change_room(room)
    end
  end
end
