defmodule EcomPaymentDisbursement.Schemas.Shopper do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}
  @primary_key false

  schema "shoppers" do
    field :id, :string, primary_key: true
    field :name, :string
    field :email, :string
    field :nif, :string

    timestamps()
  end

  @keys ~w(id name email nif)a
  @spec changeset(
          EcomPaymentDisbursement.Schemas.Shopper.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = shopper, params) do
    shopper
    |> cast(params, @keys)
    |> validate_required(@keys)
  end
end
