defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionResponse do
  @moduledoc """
  """

  @typedoc """
  .transaction

  See https://developer.swedbankpay.com/checkout/after-payment
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :type => String.t(),
          :state => String.t(),
          :amount => integer(),
          :vat_amount => integer(),
          :description => String.t(),
          :payee_reference => String.t(),
          :receipt_reference => String.t()
        }

  defstruct [
    :id,
    :type,
    :state,
    :amount,
    :vat_amount,
    :description,
    :payee_reference,
    :receipt_reference
  ]

  @doc false
  def shell() do
    %__MODULE__{}
  end
end
