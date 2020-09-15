defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest do
  @moduledoc """
  """

  @typedoc """
  Root request for initiating a payment order.

  See https://developer.swedbankpay.com/checkout/payment-menu
  """
  @type t :: %__MODULE__{
          :payment_order =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.PaymentOrderRequest.t()
        }

  @enforce_keys [:payment_order]
  @derive Poison.Encoder
  defstruct [
    :payment_order
  ]
end
