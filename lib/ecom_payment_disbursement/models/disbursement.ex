defmodule EcomPaymentDisbursement.Models.Disbursement do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias EcomPaymentDisbursement.Repo
  alias EcomPaymentDisbursement.Schemas.Disbursement

  @spec create_disbursement(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  @doc """
  Creates disbursement.

  ## Examples

      iex> create_disbursement(%{field: value})
      {:ok, %Disbursement{}}

      iex> create_disbursement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_disbursement(attrs) do
    %Disbursement{}
    |> Disbursement.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_by_date_and_merchant_id(any, any) ::
          nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  @doc """
  Fetch disbursement based on merchant & date_of_disbursement.

  ## Examples

      iex> get_by_date_and_merchant_id(%{date_of_disbursement: date_of_disbursement, merchant_id: merchant_id})
      %Disbursement{}

      iex> get_by_date_and_merchant_id({date_of_disbursement: date_of_disbursement, merchant_id: merchant_id})
      nil

  """
  def get_by_date_and_merchant_id(date_of_disbursement, merchant_id) do
    Disbursement
    |> Repo.get_by(date_of_disbursement: date_of_disbursement, merchant_id: merchant_id)
    |> Repo.preload([:merchant])
  end

  @doc """
  Fetch disbursement based on date_of_disbursement and return all
  disbursements for that day.

  ## Examples

      iex> get_by_date_and_merchant_id(%{date_of_disbursement: date_of_disbursement})
      [%Disbursement{} ..]

      iex> get_by_date_and_merchant_id(%{date_of_disbursement: date_of_disbursement})
      []

  """
  def get_all_by_date(date_of_disbursement) do
    query =
      from d in Disbursement,
        where: d.date_of_disbursement == ^date_of_disbursement,
        preload: [:merchant]

    Repo.all(query)
  end
end
