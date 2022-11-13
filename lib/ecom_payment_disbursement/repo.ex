defmodule EcomPaymentDisbursement.Repo do
  use Ecto.Repo,
    otp_app: :ecom_payment_disbursement,
    adapter: Ecto.Adapters.Postgres
end
