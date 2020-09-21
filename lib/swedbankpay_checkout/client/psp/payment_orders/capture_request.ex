defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.CaptureRequest do
  @moduledoc """
  """

  @typedoc """
  The reverse request body.

  `:payee_reference` must be unique for the whole merchant account

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :transaction =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionRequest.t()
        }

  @enforce_keys [:transaction]
  @derive Poison.Encoder
  defstruct [
    :transaction
  ]
end
