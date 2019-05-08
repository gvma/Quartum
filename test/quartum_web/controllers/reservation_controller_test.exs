defmodule QuartumWeb.ReservationControllerTest do
  use QuartumWeb.ConnCase

  alias Quartum.Reservations

  @create_attrs %{checkin_time: ~N[2010-04-17 14:00:00], checkout_time: ~N[2010-04-17 14:00:00], guest_count: 42, number: 42, status: "some status"}
  @update_attrs %{checkin_time: ~N[2011-05-18 15:01:01], checkout_time: ~N[2011-05-18 15:01:01], guest_count: 43, number: 43, status: "some updated status"}
  @invalid_attrs %{checkin_time: nil, checkout_time: nil, guest_count: nil, number: nil, status: nil}

  def fixture(:reservation) do
    {:ok, reservation} = Reservations.create_reservation(@create_attrs)
    reservation
  end

  describe "index" do
    test "lists all reservations", %{conn: conn} do
      conn = get(conn, Routes.reservation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reservations"
    end
  end

  describe "new reservation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.reservation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reservation"
    end
  end

  describe "create reservation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reservation_path(conn, :create), reservation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.reservation_path(conn, :show, id)

      conn = get(conn, Routes.reservation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reservation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reservation_path(conn, :create), reservation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reservation"
    end
  end

  describe "edit reservation" do
    setup [:create_reservation]

    test "renders form for editing chosen reservation", %{conn: conn, reservation: reservation} do
      conn = get(conn, Routes.reservation_path(conn, :edit, reservation))
      assert html_response(conn, 200) =~ "Edit Reservation"
    end
  end

  describe "update reservation" do
    setup [:create_reservation]

    test "redirects when data is valid", %{conn: conn, reservation: reservation} do
      conn = put(conn, Routes.reservation_path(conn, :update, reservation), reservation: @update_attrs)
      assert redirected_to(conn) == Routes.reservation_path(conn, :show, reservation)

      conn = get(conn, Routes.reservation_path(conn, :show, reservation))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, reservation: reservation} do
      conn = put(conn, Routes.reservation_path(conn, :update, reservation), reservation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reservation"
    end
  end

  describe "delete reservation" do
    setup [:create_reservation]

    test "deletes chosen reservation", %{conn: conn, reservation: reservation} do
      conn = delete(conn, Routes.reservation_path(conn, :delete, reservation))
      assert redirected_to(conn) == Routes.reservation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.reservation_path(conn, :show, reservation))
      end
    end
  end

  defp create_reservation(_) do
    reservation = fixture(:reservation)
    {:ok, reservation: reservation}
  end
end
