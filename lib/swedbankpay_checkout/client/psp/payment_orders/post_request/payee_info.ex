defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.PayeeInfo do
  @moduledoc """
  """

  @typedoc """
  .payment_order.payee_info
  """
  @type t :: %__MODULE__{
          :payee_id => String.t(),
          :payee_reference => String.t(),
          :payee_name => String.t() | nil,
          :product_category => String.t() | nil,
          :order_reference => String.t() | nil,
          :subsite => String.t() | nil
        }
  @enforce_keys [
    :payee_id,
    :payee_reference
  ]
  @derive Poison.Encoder
  defstruct [
    :payee_id,
    :payee_reference,
    :payee_name,
    :product_category,
    :order_reference,
    :subsite
  ]
end
