defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl do
  @moduledoc """
  """

  @typedoc """
  .payment_order.{order_items|urls|payee_info|payments|current_payment}
  """
  @type t :: %__MODULE__{
          :id => String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :id
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
