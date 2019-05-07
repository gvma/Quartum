defmodule Quartum.Establishments do
  @moduledoc """
  The Establishments context.
  """

  import Ecto.Query, warn: false
  alias Quartum.Repo

  alias Quartum.Establishments.Establishment

  @doc """
  Returns the list of establishments.

  ## Examples

      iex> list_establishments()
      [%Establishment{}, ...]

  """
  def list_establishments do
    Repo.all(Establishment)
  end

  @doc """
  Gets a single establishment.

  Raises `Ecto.NoResultsError` if the Establishment does not exist.

  ## Examples

      iex> get_establishment!(123)
      %Establishment{}

      iex> get_establishment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_establishment!(id), do: Repo.get!(Establishment, id)

  @doc """
  Creates a establishment.

  ## Examples

      iex> create_establishment(%{field: value})
      {:ok, %Establishment{}}

      iex> create_establishment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_establishment(attrs \\ %{}) do
    %Establishment{}
    |> Establishment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a establishment.

  ## Examples

      iex> update_establishment(establishment, %{field: new_value})
      {:ok, %Establishment{}}

      iex> update_establishment(establishment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_establishment(%Establishment{} = establishment, attrs) do
    establishment
    |> Establishment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Establishment.

  ## Examples

      iex> delete_establishment(establishment)
      {:ok, %Establishment{}}

      iex> delete_establishment(establishment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_establishment(%Establishment{} = establishment) do
    Repo.delete(establishment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking establishment changes.

  ## Examples

      iex> change_establishment(establishment)
      %Ecto.Changeset{source: %Establishment{}}

  """
  def change_establishment(%Establishment{} = establishment) do
    Establishment.changeset(establishment, %{})
  end
end
