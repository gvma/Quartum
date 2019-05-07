defmodule QuartumWeb.EstablishmentController do
  use QuartumWeb, :controller

  alias Quartum.Establishments
  alias Quartum.Establishments.Establishment

  def index(conn, _params) do
    establishments = Establishments.list_establishments()
    render(conn, "index.html", establishments: establishments)
  end

  def new(conn, _params) do
    changeset = Establishments.change_establishment(%Establishment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"establishment" => establishment_params}) do
    case Establishments.create_establishment(establishment_params) do
      {:ok, establishment} ->
        conn
        |> put_flash(:info, "Establishment created successfully.")
        |> redirect(to: Routes.establishment_path(conn, :show, establishment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    establishment = Establishments.get_establishment!(id)
    render(conn, "show.html", establishment: establishment)
  end

  def edit(conn, %{"id" => id}) do
    establishment = Establishments.get_establishment!(id)
    changeset = Establishments.change_establishment(establishment)
    render(conn, "edit.html", establishment: establishment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "establishment" => establishment_params}) do
    establishment = Establishments.get_establishment!(id)

    case Establishments.update_establishment(establishment, establishment_params) do
      {:ok, establishment} ->
        conn
        |> put_flash(:info, "Establishment updated successfully.")
        |> redirect(to: Routes.establishment_path(conn, :show, establishment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", establishment: establishment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    establishment = Establishments.get_establishment!(id)
    {:ok, _establishment} = Establishments.delete_establishment(establishment)

    conn
    |> put_flash(:info, "Establishment deleted successfully.")
    |> redirect(to: Routes.establishment_path(conn, :index))
  end
end
