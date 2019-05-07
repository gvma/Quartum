defmodule QuartumWeb.AddressControllerTest do
  use QuartumWeb.ConnCase

  alias Quartum.Guests

  @create_attrs %{city: "some city", country: "some country", neighborhood: "some neighborhood", state: "some state", street: "some street", street_number: "some street_number", zip_code: "some zip_code"}
  @update_attrs %{city: "some updated city", country: "some updated country", neighborhood: "some updated neighborhood", state: "some updated state", street: "some updated street", street_number: "some updated street_number", zip_code: "some updated zip_code"}
  @invalid_attrs %{city: nil, country: nil, neighborhood: nil, state: nil, street: nil, street_number: nil, zip_code: nil}

  def fixture(:address) do
    {:ok, address} = Guests.create_address(@create_attrs)
    address
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get(conn, Routes.address_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Addresses"
    end
  end

  describe "new address" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.address_path(conn, :new))
      assert html_response(conn, 200) =~ "New Address"
    end
  end

  describe "create address" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.address_path(conn, :show, id)

      conn = get(conn, Routes.address_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Address"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Address"
    end
  end

  describe "edit address" do
    setup [:create_address]

    test "renders form for editing chosen address", %{conn: conn, address: address} do
      conn = get(conn, Routes.address_path(conn, :edit, address))
      assert html_response(conn, 200) =~ "Edit Address"
    end
  end

  describe "update address" do
    setup [:create_address]

    test "redirects when data is valid", %{conn: conn, address: address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @update_attrs)
      assert redirected_to(conn) == Routes.address_path(conn, :show, address)

      conn = get(conn, Routes.address_path(conn, :show, address))
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, address: address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Address"
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete(conn, Routes.address_path(conn, :delete, address))
      assert redirected_to(conn) == Routes.address_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.address_path(conn, :show, address))
      end
    end
  end

  defp create_address(_) do
    address = fixture(:address)
    {:ok, address: address}
  end
end
