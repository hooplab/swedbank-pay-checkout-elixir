defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.ReverseResponse do
  @moduledoc """
  """

  @typedoc """
  root response for creating a reversal

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :payment => String.t(),
          :reversals => SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action.t()
        }

  @derive Poison.Encoder
  defstruct [
    :payment,
    :reversals
  ]

  @doc false
  def shell() do
    %__MODULE__{
      reversals: SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action.shell()
    }
  end
end
