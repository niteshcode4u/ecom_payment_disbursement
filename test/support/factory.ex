defmodule EcomPaymentDisbursement.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: EcomPaymentDisbursement.Repo

  alias EcomPaymentDisbursement.Schemas.Disbursement
  alias EcomPaymentDisbursement.Schemas.Merchant
  alias EcomPaymentDisbursement.Schemas.Order
  alias EcomPaymentDisbursement.Schemas.Shopper

  def merchant_factory do
    %Merchant{
      id: "#{:rand.uniform(9999)}",
      name: "Flatley-Rowe_#{:rand.uniform(9999)}",
      email: "info@flatley_#{:rand.uniform(9999)}-rowe.com",
      cif: "B61111_#{:rand.uniform(9999)}"
    }
  end

  def shopper_factory do
    %Shopper{
      id: "#{:rand.uniform(9999)}",
      name: "Natosha Jacobi_#{:rand.uniform(9999)}",
      email: "natosha.jacobi@flatley_#{:rand.uniform(9999)}-rowe.com",
      nif: "N61111_#{:rand.uniform(9999)}"
    }
  end

  def order_factory do
    merchant = insert(:merchant)
    shopper = insert(:shopper)

    %Order{
      id: "#{:rand.uniform(9999)}",
      amount: "190.61",
      created_at: "01/01/2018 07:36:00",
      completed_at: "",
      merchant: merchant,
      shopper: shopper
    }
  end

  def disbursement_factory do
    merchant = insert(:merchant)

    %Disbursement{
      amount: "199.32",
      date_of_disbursement: "2022-11-19",
      merchant: merchant
    }
  end
end
