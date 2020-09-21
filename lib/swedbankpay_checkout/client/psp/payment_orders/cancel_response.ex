defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.CancelResponse do
  @moduledoc """
  """

  @typedoc """
  root response for creating a cancellation

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :payment => String.t(),
          :cancellation => SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action.t()
        }

  @derive Poison.Encoder
  defstruct [
    :payment,
    :cancellation
  ]

  @doc false
  def shell() do
    %__MODULE__{
      cancellation: SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action.shell()
    }
  end
end
