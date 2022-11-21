defmodule EcomPaymentDisbursementWeb.Router do
  use EcomPaymentDisbursementWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EcomPaymentDisbursementWeb do
    pipe_through :api

    get "/disbursements", DisbursementController, :get_disbursements
  end
end
