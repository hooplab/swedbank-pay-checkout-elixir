defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.CaptureResponse do
  @moduledoc """
  """

  @typedoc """
  root response for creating a capture

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :payment => String.t(),
          :capture => SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action.t()
        }

  @derive Poison.Encoder
  defstruct [
    :payment,
    :capture
  ]

  @doc false
  def shell() do
    %__MODULE__{
      capture: SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.Action.shell()
    }
  end
end
