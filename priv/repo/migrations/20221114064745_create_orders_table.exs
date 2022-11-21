defmodule EcomPaymentDisbursement.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table("orders", primary_key: false) do
      add :id, :string, primary_key: true
      add :amount, :string, null: false
      add :created_at, :string
      add :completed_at, :string

      add :merchant_id, references(:merchants, type: :string, on_delete: :nothing)
      add :shopper_id, references(:shoppers, type: :string, on_delete: :nothing)

      timestamps()
    end
  end
end
