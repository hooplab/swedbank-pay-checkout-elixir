defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.RootResponse do
  @moduledoc """
  """

  @typedoc """
  root response for initiating a payment order.

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

  @doc """
  Internal function used for response parsing.
  """
  def shell() do
    %__MODULE__{
      payment_order: SwedbankpayCheckout.Model.PaymentOrder.shell(),
      operations: [SwedbankpayCheckout.Model.Operation.shell()]
    }
  end
end