defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.CancelRequest do
  @moduledoc """
  """

  @typedoc """
  The cancel request body.

  `:payee_reference` must be unique for the whole merchant account

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :payee_reference => String.t(),
          :description => String.t()
        }

  @enforce_keys [:payee_reference, :description]
  @derive Poison.Encoder
  defstruct [
    :payee_reference,
    :description
  ]
end
