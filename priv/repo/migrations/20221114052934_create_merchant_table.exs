defmodule EcomPaymentDisbursement.Repo.Migrations.CreateMerchantTable do
  use Ecto.Migration

  def change do
    create table("merchants", primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string, null: false
      add :email, :string, null: false
      add :cif, :string

      timestamps()
    end

    create unique_index("merchants", [:email])
  end
end
