defmodule EcomPaymentDisbursement.Repo.Migrations.CreateShoppersTable do
  use Ecto.Migration

  def change do
    create table("shoppers", primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string, null: false
      add :email, :string, null: false
      add :nif, :string

      timestamps()
    end

    create unique_index("shoppers", [:email])
  end
end
