defmodule EcomPaymentDisbursement.Schemas.Merchant do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}
  @primary_key false

  schema "merchants" do
    field :id, :string, primary_key: true
    field :name, :string
    field :email, :string
    field :cif, :string

    timestamps()
  end

  @keys ~w(id name email cif)a

  @spec changeset(
          EcomPaymentDisbursement.Schemas.Merchant.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = merchant, params) do
    merchant
    |> cast(params, @keys)
    |> validate_required(@keys)
  end
end
