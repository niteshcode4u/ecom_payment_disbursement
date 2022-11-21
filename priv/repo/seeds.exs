defmodule Seed do
  @moduledoc """
    To seed data into database please use `mix run priv/repo/seeds.exs` into terminal
  """

  alias EcomPaymentDisbursement.Repo
  alias EcomPaymentDisbursement.Schemas.Merchant
  alias EcomPaymentDisbursement.Schemas.Order
  alias EcomPaymentDisbursement.Schemas.Shopper

  def seed_merchant do
    {:ok, json_data} = File.read("priv/repo/data/merchants.json")
    {:ok, %{"RECORDS" => merchant_map}} = Jason.decode(json_data)

    changesets = update_records_to_changeset(merchant_map)
    Repo.insert_all(Merchant, changesets)
  end

  def seed_shopper do
    {:ok, json_data} = File.read("priv/repo/data/shoppers.json")
    {:ok, %{"RECORDS" => shopper_map}} = Jason.decode(json_data)

    changesets = update_records_to_changeset(shopper_map)
    Repo.insert_all(Shopper, changesets)
  end

  def seed_order do
    {:ok, json_data} = File.read("priv/repo/data/orders.json")
    {:ok, %{"RECORDS" => order_map}} = Jason.decode(json_data)

    changesets = update_records_to_changeset(order_map)
    Repo.insert_all(Order, changesets)
  end

  defp update_records_to_changeset(records) do
    Enum.map(records, fn record ->
      request_data = for {key, val} <- record, into: %{}, do: {String.to_atom(key), val}
      time = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      request_data
      |> Map.put(:updated_at, time)
      |> Map.put(:inserted_at, time)
    end)
  end
end

Seed.seed_merchant()
Seed.seed_shopper()
Seed.seed_order()
