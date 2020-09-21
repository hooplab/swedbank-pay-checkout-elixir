defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action do
  @moduledoc """
  """

  @typedoc """
  capture|cancellation|reversal response .capture|.cancellation|.reversals

  See https://developer.swedbankpay.com/checkout/payment-menu
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :transaction =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionResponse.t()
        }

  @derive Poison.Encoder
  defstruct [
    :id,
    :transaction
  ]

  @doc false
  def shell() do
    %__MODULE__{
      transaction: SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionResponse.shell()
    }
  end
end
