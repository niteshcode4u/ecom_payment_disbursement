defmodule EcomPaymentDisbursement.Schemas.Order do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias EcomPaymentDisbursement.Schemas.{Merchant, Shopper}

  @type t :: %__MODULE__{}
  @primary_key false

  schema "orders" do
    field :id, :string, primary_key: true
    field :amount, :string
    field :created_at, :string
    field :completed_at, :string

    belongs_to :merchant, Merchant, type: :string
    belongs_to :shopper, Shopper, type: :string

    timestamps()
  end

  @optional_keys ~w(id amount created_at completed_at merchant_id shopper_id)a
  @required_keys ~w(id amount created_at merchant_id shopper_id)a

  @spec changeset(
          EcomPaymentDisbursement.Schemas.Order.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = order, params) do
    order
    |> cast(params, @optional_keys ++ @required_keys)
    |> validate_required(@required_keys)
  end
end
