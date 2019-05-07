defmodule Quartum.GuestsTest do
  use Quartum.DataCase

  alias Quartum.Guests

  describe "addresses" do
    alias Quartum.Guests.Address

    @valid_attrs %{city: "some city", country: "some country", neighborhood: "some neighborhood", state: "some state", street: "some street", street_number: "some street_number", zip_code: "some zip_code"}
    @update_attrs %{city: "some updated city", country: "some updated country", neighborhood: "some updated neighborhood", state: "some updated state", street: "some updated street", street_number: "some updated street_number", zip_code: "some updated zip_code"}
    @invalid_attrs %{city: nil, country: nil, neighborhood: nil, state: nil, street: nil, street_number: nil, zip_code: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Guests.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Guests.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Guests.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Guests.create_address(@valid_attrs)
      assert address.city == "some city"
      assert address.country == "some country"
      assert address.neighborhood == "some neighborhood"
      assert address.state == "some state"
      assert address.street == "some street"
      assert address.street_number == "some street_number"
      assert address.zip_code == "some zip_code"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Guests.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Guests.update_address(address, @update_attrs)
      assert address.city == "some updated city"
      assert address.country == "some updated country"
      assert address.neighborhood == "some updated neighborhood"
      assert address.state == "some updated state"
      assert address.street == "some updated street"
      assert address.street_number == "some updated street_number"
      assert address.zip_code == "some updated zip_code"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Guests.update_address(address, @invalid_attrs)
      assert address == Guests.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Guests.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Guests.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Guests.change_address(address)
    end
  end

  describe "guests" do
    alias Quartum.Guests.Guest

    @valid_attrs %{age: 42, birthdate: ~D[2010-04-17], cpf: "some cpf", email: "some email", full_name: "some full_name", gender: true, photo: "some photo", primary_phone: "some primary_phone", rg: "some rg", secondary_phone: "some secondary_phone"}
    @update_attrs %{age: 43, birthdate: ~D[2011-05-18], cpf: "some updated cpf", email: "some updated email", full_name: "some updated full_name", gender: false, photo: "some updated photo", primary_phone: "some updated primary_phone", rg: "some updated rg", secondary_phone: "some updated secondary_phone"}
    @invalid_attrs %{age: nil, birthdate: nil, cpf: nil, email: nil, full_name: nil, gender: nil, photo: nil, primary_phone: nil, rg: nil, secondary_phone: nil}

    def guest_fixture(attrs \\ %{}) do
      {:ok, guest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Guests.create_guest()

      guest
    end

    test "list_guests/0 returns all guests" do
      guest = guest_fixture()
      assert Guests.list_guests() == [guest]
    end

    test "get_guest!/1 returns the guest with given id" do
      guest = guest_fixture()
      assert Guests.get_guest!(guest.id) == guest
    end

    test "create_guest/1 with valid data creates a guest" do
      assert {:ok, %Guest{} = guest} = Guests.create_guest(@valid_attrs)
      assert guest.age == 42
      assert guest.birthdate == ~D[2010-04-17]
      assert guest.cpf == "some cpf"
      assert guest.email == "some email"
      assert guest.full_name == "some full_name"
      assert guest.gender == true
      assert guest.photo == "some photo"
      assert guest.primary_phone == "some primary_phone"
      assert guest.rg == "some rg"
      assert guest.secondary_phone == "some secondary_phone"
    end

    test "create_guest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Guests.create_guest(@invalid_attrs)
    end

    test "update_guest/2 with valid data updates the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{} = guest} = Guests.update_guest(guest, @update_attrs)
      assert guest.age == 43
      assert guest.birthdate == ~D[2011-05-18]
      assert guest.cpf == "some updated cpf"
      assert guest.email == "some updated email"
      assert guest.full_name == "some updated full_name"
      assert guest.gender == false
      assert guest.photo == "some updated photo"
      assert guest.primary_phone == "some updated primary_phone"
      assert guest.rg == "some updated rg"
      assert guest.secondary_phone == "some updated secondary_phone"
    end

    test "update_guest/2 with invalid data returns error changeset" do
      guest = guest_fixture()
      assert {:error, %Ecto.Changeset{}} = Guests.update_guest(guest, @invalid_attrs)
      assert guest == Guests.get_guest!(guest.id)
    end

    test "delete_guest/1 deletes the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{}} = Guests.delete_guest(guest)
      assert_raise Ecto.NoResultsError, fn -> Guests.get_guest!(guest.id) end
    end

    test "change_guest/1 returns a guest changeset" do
      guest = guest_fixture()
      assert %Ecto.Changeset{} = Guests.change_guest(guest)
    end
  end
end
