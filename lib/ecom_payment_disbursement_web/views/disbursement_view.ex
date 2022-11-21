defmodule EcomPaymentDisbursementWeb.DisbursementView do
  use EcomPaymentDisbursementWeb, :view

  def render("disbursements.json", %{disbursements: disbursements}) do
    render_many(disbursements, __MODULE__, "disbursement.json")
  end

  def render("disbursement.json", %{disbursement: disbursement}) do
    %{
      merchant_id: disbursement.merchant_id,
      merchant_name: disbursement.merchant.name,
      merchant_email: disbursement.merchant.email,
      amount: disbursement.amount,
      date_of_disbursement: disbursement.date_of_disbursement
    }
  end
end
