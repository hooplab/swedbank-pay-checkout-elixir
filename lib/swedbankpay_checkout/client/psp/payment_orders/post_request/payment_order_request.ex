defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.PaymentOrderRequest do
  @moduledoc """
  """

  @typedoc """
  .payment_order.operation
  """
  @type op :: :Purchase

  @enforce_keys [
    :operation,
    :currency,
    :amount,
    :vat_amount,
    :description,
    :generate_recurrence_token,
    :user_agent,
    :language,
    :instrument,
    :urls,
    :payee_info,
    :payer,
    :order_items
  ]
  @derive Poison.Encoder
  defstruct [
    :operation,
    :currency,
    :amount,
    :vat_amount,
    :description,
    :user_agent,
    :language,
    :instrument,
    :generate_recurrence_token,
    :urls,
    :payee_info,
    :payer,
    :order_items,
    :risk_indicator
  ]

  @typedoc """
  .payment_order
  """
  @type t :: %__MODULE__{
          :operation => op,
          :currency => SwedbankpayCheckout.Model.Currency.t(),
          :amount => Integer.t(),
          :vat_amount => Integer.t(),
          :description => String.t(),
          :instrument => String.t() | nil,
          :generate_recurrence_token => boolean(),
          :user_agent => String.t(),
          :language => SwedbankpayCheckout.Model.Language.t(),
          :urls => SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.Urls.t(),
          :payee_info => SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.PayeeInfo.t(),
          :payer => SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.Payer.t(),
          :order_items => [SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem.t()],
          :risk_indicator =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.RiskIndicator.t() | nil
        }
end
