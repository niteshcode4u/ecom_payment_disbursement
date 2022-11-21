defmodule EcomPaymentDisbursement do
  @moduledoc """
  EcomPaymentDisbursement keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias EcomPaymentDisbursement.Models.Disbursement

  @spec fetch_disbursements(any) :: {:error, :not_found} | {:ok, any}
  @doc """
  Fetch available disbursement based on date_of_disbursement & merchant_id

  iex> fetch_disbursements(%{"date" => date_of_disbursement, "merchant_id" => merchant_id})
  {:ok, [%Disbursement{}]}

  iex> fetch_disbursements(%{"date" => date_of_disbursement, "merchant_id" => merchant_id})
  {:ok, []}

  iex> fetch_disbursements(%{"date" => date_of_disbursement})
  {:ok, [%Disbursement1{}, %Disbursement2{}, ..]}

  iex> fetch_disbursements(_some_invalid_map)
  {:error, :not_found}

  """
  def fetch_disbursements(%{"date" => date_of_disbursement, "merchant_id" => merchant_id}) do
    {:ok,
     date_of_disbursement |> Disbursement.get_by_date_and_merchant_id(merchant_id) |> List.wrap()}
  end

  def fetch_disbursements(%{"date" => date_of_disbursement}) do
    {:ok, Disbursement.get_all_by_date(date_of_disbursement)}
  end

  def fetch_disbursements(_params) do
    {:error, :not_found}
  end
end
