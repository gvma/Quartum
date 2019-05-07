defmodule QuartumWeb.PaymentController do
  use QuartumWeb, :controller

  alias Quartum.Reservations
  alias Quartum.Reservations.Payment

  def index(conn, _params) do
    payments = Reservations.list_payments()
    render(conn, "index.html", payments: payments)
  end

  def new(conn, _params) do
    changeset = Reservations.change_payment(%Payment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"payment" => payment_params}) do
    case Reservations.create_payment(payment_params) do
      {:ok, payment} ->
        conn
        |> put_flash(:info, "Payment created successfully.")
        |> redirect(to: Routes.payment_path(conn, :show, payment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Reservations.get_payment!(id)
    render(conn, "show.html", payment: payment)
  end

  def edit(conn, %{"id" => id}) do
    payment = Reservations.get_payment!(id)
    changeset = Reservations.change_payment(payment)
    render(conn, "edit.html", payment: payment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "payment" => payment_params}) do
    payment = Reservations.get_payment!(id)

    case Reservations.update_payment(payment, payment_params) do
      {:ok, payment} ->
        conn
        |> put_flash(:info, "Payment updated successfully.")
        |> redirect(to: Routes.payment_path(conn, :show, payment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", payment: payment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment = Reservations.get_payment!(id)
    {:ok, _payment} = Reservations.delete_payment(payment)

    conn
    |> put_flash(:info, "Payment deleted successfully.")
    |> redirect(to: Routes.payment_path(conn, :index))
  end
end
