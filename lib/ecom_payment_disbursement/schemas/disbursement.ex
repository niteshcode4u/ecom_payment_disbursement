defmodule EcomPaymentDisbursement.Schemas.Disbursement do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias EcomPaymentDisbursement.Schemas.Merchant

  @type t :: %__MODULE__{}

  schema "disbursements" do
    field :amount, :float
    field :date_of_disbursement, :date

    belongs_to :merchant, Merchant, type: :string

    timestamps()
  end

  @keys ~w(amount date_of_disbursement merchant_id)a

  @spec changeset(
          EcomPaymentDisbursement.Schemas.Disbursement.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = disbursement, params) do
    disbursement
    |> cast(params, @keys)
    |> validate_required(@keys)
    |> unique_constraint([:date_of_disbursement, :merchant_id])
  end
end
