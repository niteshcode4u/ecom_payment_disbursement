defmodule EcomPaymentDisbursementWeb.DisbursementContollerTest do
  use EcomPaymentDisbursementWeb.ConnCase, async: false
  import EcomPaymentDisbursement.Factory

  describe "get_disbursements" do
    test "Success: return list of results when correct data is given", %{conn: conn} do
      merchant = insert(:merchant)
      insert(:disbursement, %{merchant: merchant})

      resp =
        conn
        |> get(Routes.disbursement_path(conn, :get_disbursements), date: "2022-11-19")
        |> json_response(200)

      assert resp == [
               %{
                 "amount" => 199.32,
                 "date_of_disbursement" => "2022-11-19",
                 "merchant_email" => merchant.email,
                 "merchant_id" => merchant.id,
                 "merchant_name" => merchant.name
               }
             ]
    end

    test "Success: return empty list when correct date is given however data not available", %{
      conn: conn
    } do
      resp =
        conn
        |> get(Routes.disbursement_path(conn, :get_disbursements), date: "2022-11-19")
        |> json_response(200)

      assert resp == []
    end

    test "Success: return empty list when correct date & merchant_id is given however data not available",
         %{conn: conn} do
      resp =
        conn
        |> get(Routes.disbursement_path(conn, :get_disbursements),
          date: "2022-11-19",
          merchant_id: "1"
        )
        |> json_response(200)

      assert resp == []
    end

    test "Error: return not found when incorrect data given", %{conn: conn} do
      resp =
        conn
        |> get(Routes.disbursement_path(conn, :get_disbursements))
        |> json_response(404)

      assert resp == %{"error" => "Invalid query. Please verify and send again!"}
    end
  end
end
