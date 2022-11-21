defmodule EcomPaymentDisbursement.Repo.Migrations.CreateDisbursementTable do
  use Ecto.Migration

  def change do
    create table("disbursements") do
      add :amount, :float, null: false
      add :date_of_disbursement, :date

      add :merchant_id, references(:merchants, type: :string, on_delete: :nothing)

      timestamps()
    end

    create(unique_index(:disbursements, [:date_of_disbursement, :merchant_id]))
  end
end
