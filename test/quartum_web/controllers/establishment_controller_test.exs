defmodule QuartumWeb.EstablishmentControllerTest do
  use QuartumWeb.ConnCase

  alias Quartum.Establishments

  @create_attrs %{name: "some name", specifications: "some specifications"}
  @update_attrs %{name: "some updated name", specifications: "some updated specifications"}
  @invalid_attrs %{name: nil, specifications: nil}

  def fixture(:establishment) do
    {:ok, establishment} = Establishments.create_establishment(@create_attrs)
    establishment
  end

  describe "index" do
    test "lists all establishments", %{conn: conn} do
      conn = get(conn, Routes.establishment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Establishments"
    end
  end

  describe "new establishment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.establishment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Establishment"
    end
  end

  describe "create establishment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.establishment_path(conn, :create), establishment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.establishment_path(conn, :show, id)

      conn = get(conn, Routes.establishment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Establishment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.establishment_path(conn, :create), establishment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Establishment"
    end
  end

  describe "edit establishment" do
    setup [:create_establishment]

    test "renders form for editing chosen establishment", %{conn: conn, establishment: establishment} do
      conn = get(conn, Routes.establishment_path(conn, :edit, establishment))
      assert html_response(conn, 200) =~ "Edit Establishment"
    end
  end

  describe "update establishment" do
    setup [:create_establishment]

    test "redirects when data is valid", %{conn: conn, establishment: establishment} do
      conn = put(conn, Routes.establishment_path(conn, :update, establishment), establishment: @update_attrs)
      assert redirected_to(conn) == Routes.establishment_path(conn, :show, establishment)

      conn = get(conn, Routes.establishment_path(conn, :show, establishment))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, establishment: establishment} do
      conn = put(conn, Routes.establishment_path(conn, :update, establishment), establishment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Establishment"
    end
  end

  describe "delete establishment" do
    setup [:create_establishment]

    test "deletes chosen establishment", %{conn: conn, establishment: establishment} do
      conn = delete(conn, Routes.establishment_path(conn, :delete, establishment))
      assert redirected_to(conn) == Routes.establishment_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.establishment_path(conn, :show, establishment))
      end
    end
  end

  defp create_establishment(_) do
    establishment = fixture(:establishment)
    {:ok, establishment: establishment}
  end
end
