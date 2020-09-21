defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionRequest do
  @moduledoc """
  """

  @typedoc """
  .transaction

  `:payee_reference` must be unique for the whole merchant account
  `:receipt_reference` must be unique for the whole merchant account (or nil)

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :amount => integer(),
          :vat_amount => integer(),
          :payee_reference => String.t(),
          :receipt_reference => String.t() | nil,
          :description => String.t(),
          :order_items => [
            SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem.t()
          ]
        }
  @enforce_keys [
    :amount,
    :vat_amount,
    :payee_reference,
    :receipt_reference,
    :description,
    :order_items
  ]
  @derive Poison.Encoder
  defstruct [
    :amount,
    :vat_amount,
    :payee_reference,
    :receipt_reference,
    :description,
    :order_items
  ]
end
