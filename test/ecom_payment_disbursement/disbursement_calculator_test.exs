defmodule EcomPaymentDisbursement.DisbursementCalculatorTest do
  use EcomPaymentDisbursement.DataCase, async: false
  import EcomPaymentDisbursement.Factory
  alias EcomPaymentDisbursement.DisbursementCalculator

  describe "DisbursementCalculator.start_disbursement/1" do
    test "Disburse the completed orders when it's Monday" do
      merchant = insert(:merchant)
      insert(:order, merchant: merchant, completed_at: "18/11/2022 10:11:11", amount: "49.12")
      insert(:order, merchant: merchant, completed_at: "17/11/2022 10:11:11", amount: "112.21")
      insert(:order, merchant: merchant, completed_at: "16/11/2022 10:11:11", amount: "445.34")

      assert DisbursementCalculator.start_disbursement(1)
    end

    test "Start disbursement process for next Monday" do
      merchant = insert(:merchant)
      insert(:order, merchant: merchant, completed_at: "18/11/2022 10:11:11", amount: "49.12")
      insert(:order, merchant: merchant, completed_at: "17/11/2022 10:11:11", amount: "112.21")
      insert(:order, merchant: merchant, completed_at: "16/11/2022 10:11:11", amount: "445.34")

      assert DisbursementCalculator.start_disbursement(4)
    end
  end
end
