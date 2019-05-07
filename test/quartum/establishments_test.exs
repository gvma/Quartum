defmodule Quartum.EstablishmentsTest do
  use Quartum.DataCase

  alias Quartum.Establishments

  describe "establishments" do
    alias Quartum.Establishments.Establishment

    @valid_attrs %{name: "some name", specifications: "some specifications"}
    @update_attrs %{name: "some updated name", specifications: "some updated specifications"}
    @invalid_attrs %{name: nil, specifications: nil}

    def establishment_fixture(attrs \\ %{}) do
      {:ok, establishment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Establishments.create_establishment()

      establishment
    end

    test "list_establishments/0 returns all establishments" do
      establishment = establishment_fixture()
      assert Establishments.list_establishments() == [establishment]
    end

    test "get_establishment!/1 returns the establishment with given id" do
      establishment = establishment_fixture()
      assert Establishments.get_establishment!(establishment.id) == establishment
    end

    test "create_establishment/1 with valid data creates a establishment" do
      assert {:ok, %Establishment{} = establishment} = Establishments.create_establishment(@valid_attrs)
      assert establishment.name == "some name"
      assert establishment.specifications == "some specifications"
    end

    test "create_establishment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Establishments.create_establishment(@invalid_attrs)
    end

    test "update_establishment/2 with valid data updates the establishment" do
      establishment = establishment_fixture()
      assert {:ok, %Establishment{} = establishment} = Establishments.update_establishment(establishment, @update_attrs)
      assert establishment.name == "some updated name"
      assert establishment.specifications == "some updated specifications"
    end

    test "update_establishment/2 with invalid data returns error changeset" do
      establishment = establishment_fixture()
      assert {:error, %Ecto.Changeset{}} = Establishments.update_establishment(establishment, @invalid_attrs)
      assert establishment == Establishments.get_establishment!(establishment.id)
    end

    test "delete_establishment/1 deletes the establishment" do
      establishment = establishment_fixture()
      assert {:ok, %Establishment{}} = Establishments.delete_establishment(establishment)
      assert_raise Ecto.NoResultsError, fn -> Establishments.get_establishment!(establishment.id) end
    end

    test "change_establishment/1 returns a establishment changeset" do
      establishment = establishment_fixture()
      assert %Ecto.Changeset{} = Establishments.change_establishment(establishment)
    end
  end
end
