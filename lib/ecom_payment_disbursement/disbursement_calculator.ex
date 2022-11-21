defmodule EcomPaymentDisbursement.DisbursementCalculator do
  @moduledoc """
  Disburse the amount for merchant and schedule for next disbursement
  """

  use GenServer

  import Ecto.Query, only: [from: 2]

  alias EcomPaymentDisbursement.Models.Disbursement
  alias EcomPaymentDisbursement.Repo
  alias EcomPaymentDisbursement.Schemas.Order

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, [], name: :disbursement_calculator)
  end

  @impl true
  @spec init(any) :: {:ok, any}
  def init(state) do
    Process.send(:disbursement_calculator, :create_disbursement, [:nosuspend])

    {:ok, state}
  end

  @impl GenServer
  def handle_info(:create_disbursement, state) do
    Date.utc_today()
    |> Date.day_of_week()
    |> start_disbursement()

    {:noreply, state}
  end

  @spec start_disbursement(number) :: reference
  def start_disbursement(1) do
    process_disbursement()

    Process.send_after(:disbursement_calculator, :create_disbursement, calculate_interval(1))
  end

  def start_disbursement(num) do
    Process.send_after(:disbursement_calculator, :create_disbursement, calculate_interval(num))
  end

  defp process_disbursement do
    query_for_completed_orders()
    |> Repo.all()
    |> Enum.group_by(& &1.merchant_id)
    |> Enum.each(fn {merchant_id, orders} ->
      attributes = %{
        amount: calculate_total_for_merchant(orders),
        merchant_id: merchant_id,
        date_of_disbursement: Date.utc_today()
      }

      Disbursement.create_disbursement(attributes)
    end)
  end

  defp calculate_total_for_merchant(orders) do
    Enum.reduce(orders, 0, fn order, total ->
      {amount, _ignore} = Float.parse(order.amount)

      cond do
        amount < 50 -> total + amount * 1.01
        amount >= 50 and amount < 300 -> total + amount * 1.0095
        true -> total + amount * 1.0085
      end
    end)
  end

  defp query_for_completed_orders do
    {from_date, to_date} = get_date_range_for_disbursement()

    from o in Order,
      where: fragment("? BETWEEN ? AND ?", o.completed_at, ^from_date, ^to_date),
      group_by: [o.merchant_id, o.amount],
      order_by: [o.merchant_id],
      select: %{
        merchant_id: o.merchant_id,
        amount: o.amount
      }
  end

  defp get_date_range_for_disbursement do
    [from_year, from_mon, from_day] =
      Date.utc_today() |> Date.add(-7) |> to_string() |> String.split("-")

    [to_year, to_mon, to_day] =
      Date.utc_today() |> Date.add(-1) |> to_string() |> String.split("-")

    {"#{from_day}/#{from_mon}/#{from_year} 00:00:00", "#{to_day}/#{to_mon}/#{to_year} 23:59:59"}
  end

  defp calculate_interval(num) do
    remaining_seconds_of_day = Time.diff(~T[23:59:59], Time.utc_now())
    remaining_days_in_seconds = (7 - num) * 86_400

    # Adding all times into seconds and in last adding 2 extra seconds
    # Disbursement will perform at midnight of every Monday(start of Monday - utc time)
    (remaining_days_in_seconds + remaining_seconds_of_day + 2) * 1000
  end
end
