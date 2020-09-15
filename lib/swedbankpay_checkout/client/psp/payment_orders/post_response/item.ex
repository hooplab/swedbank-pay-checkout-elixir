defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.Item do
  @moduledoc """
  """

  @typedoc """
  .payment_order.items
  """
  @type t :: %__MODULE__{
          :credit_card =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.CreditCardItem.t()
        }
  @derive Poison.Encoder
  defstruct [
    :credit_card
  ]

  @doc false
  def shell() do
    %__MODULE__{
      credit_card:
        SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.CreditCardItem.shell()
    }
  end
end
