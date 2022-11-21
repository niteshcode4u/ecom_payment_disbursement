defmodule EcomPaymentDisbursementWeb.DisbursementController do
  @moduledoc false

  use EcomPaymentDisbursementWeb, :controller

  @spec get_disbursements(Plug.Conn.t(), any) :: Plug.Conn.t()
  def get_disbursements(conn, params) do
    case EcomPaymentDisbursement.fetch_disbursements(params) do
      {:ok, disbursements} ->
        conn
        |> put_view(EcomPaymentDisbursementWeb.DisbursementView)
        |> render("disbursements.json", %{disbursements: disbursements})

      {:error, :not_found} ->
        conn
        |> put_view(EcomPaymentDisbursementWeb.ErrorView)
        |> put_status(:not_found)
        |> render("404.json", %{error: :not_found})
    end
  end
end
