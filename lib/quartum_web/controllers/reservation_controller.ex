defmodule QuartumWeb.ReservationController do
  use QuartumWeb, :controller

  alias Quartum.Reservations
  alias Quartum.Reservations.Reservation
  alias Quartum.Guests

  def index(conn, _params) do
    reservations = Reservations.list_reservations()
    render(conn, "index.html", reservations: reservations)
  end

  def new(conn, _params) do
    changeset = Reservations.change_reservation(%Reservation{})

    rooms = Enum.map(Reservations.list_rooms(), fn x -> {:"#{x.habitational_unit}", x.id} end)
    guests = Enum.map(Guests.list_guests(), fn x -> {:"#{x.full_name} #{x.cpf} #{x.primary_phone}", x.id} end)
    payments = Enum.map(Reservations.list_payments(), fn x -> {:"#{x.obs}", x.id} end)

    render(conn, "new.html", changeset: changeset, rooms: rooms, guests: guests, payments: payments)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    case Reservations.create_reservation(reservation_params) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation created successfully.")
        |> redirect(to: Routes.reservation_path(conn, :show, reservation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Reservations.get_reservation!(id)
    render(conn, "show.html", reservation: reservation)
  end

  def edit(conn, %{"id" => id}) do
    reservation = Reservations.get_reservation!(id)
    changeset = Reservations.change_reservation(reservation)
    rooms = Enum.map(Reservations.list_rooms(), fn x -> {:"#{x.habitational_unit}", x.id} end)
    guests = Enum.map(Guests.list_guests(), fn x -> {:"#{x.full_name} #{x.cpf} #{x.primary_phone}", x.id} end)
    payments = Enum.map(Reservations.list_payments(), fn x -> {:"#{x.obs}", x.id} end)

    render(conn, "edit.html", reservation: reservation, changeset: changeset,
     rooms: rooms, guests: guests, payments: payments)
  end

  def update(conn, %{"id" => id, "reservation" => reservation_params}) do
    reservation = Reservations.get_reservation!(id)

    case Reservations.update_reservation(reservation, reservation_params) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, "Reservation updated successfully.")
        |> redirect(to: Routes.reservation_path(conn, :show, reservation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reservation: reservation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Reservations.get_reservation!(id)
    {:ok, _reservation} = Reservations.delete_reservation(reservation)

    conn
    |> put_flash(:info, "Reservation deleted successfully.")
    |> redirect(to: Routes.reservation_path(conn, :index))
  end
end
