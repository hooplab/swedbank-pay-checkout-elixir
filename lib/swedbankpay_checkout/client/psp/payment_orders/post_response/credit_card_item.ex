defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.CreditCardItem do
  @moduledoc """
  """

  @typedoc """
  .payment_order.items.credit_card
  """
  @type t :: %__MODULE__{
          :card_brands => [String.t()]
        }
  @derive Poison.Encoder
  defstruct [
    :card_brands
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
