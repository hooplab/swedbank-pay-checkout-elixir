defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.OrderResponse do
  @moduledoc """
  """

  @typedoc """
  root response for initiating a payment order or fetching an order

  See https://developer.swedbankpay.com/checkout/payment-menu
  """
  @type t :: %__MODULE__{
          :payment_order => SwedbankpayCheckout.Model.PaymentOrderResponse.t(),
          :operations => [SwedbankpayCheckout.Model.Operation.t()]
        }

  @derive Poison.Encoder
  defstruct [
    :payment_order,
    :operations
  ]

  @doc false
  def shell() do
    %__MODULE__{
      payment_order: SwedbankpayCheckout.Model.PaymentOrder.shell(),
      operations: [SwedbankpayCheckout.Model.Operation.shell()]
    }
  end
end
