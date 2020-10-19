defmodule SwedbankpayCheckout.Model.CurrentPayment do
  @moduledoc """
  """

  @typedoc """
  See https://developer.swedbankpay.com/checkout/payment-menu
  """
  @type t :: %__MODULE__{
               :id => String.t(),
               :menu_element_name => String.t(),
               :payment => SwedbankpayCheckout.Model.Payment.t(),
               :operations => [SwedbankpayCheckout.Model.Operation.t()]
        }

  @derive Poison.Encoder
  defstruct [
    :id,
    :menu_element_name,
    :payment,
    :operations
  ]

  @doc false
  def shell() do
    %__MODULE__{
      payment: SwedbankpayCheckout.Model.Payment.shell(),
      operations: [SwedbankpayCheckout.Model.Operation.shell()]
    }
  end
end
