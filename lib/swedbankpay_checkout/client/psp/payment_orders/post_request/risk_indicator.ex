defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.RiskIndicator do
  @moduledoc """
  """

  @typedoc """
  .payment_order.risk_indicator

  See documentation for the magic numbers and strings required.
  https://developer.swedbankpay.com/checkout/payment-menu
  """
  @type t :: %__MODULE__{
          :delivery_email_address => String.t() | nil,
          :delivery_time_frame_indicator => String.t() | nil,
          :pre_order_date => String.t() | nil,
          :pre_order_purchase_indicator => String.t() | nil,
          :ship_indicator => String.t() | nil,
          :gift_card_purchase => boolean() | nil,
          :re_order_purchase_indicator => String.t() | nil,
          :pick_up_address =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.RiskIndicatorPickUpAddress.t()
            | nil
        }

  @derive Poison.Encoder
  defstruct [
    :delivery_email_address,
    :delivery_time_frame_indicator,
    :pre_order_date,
    :pre_order_purchase_indicator,
    :ship_indicator,
    :gift_card_purchase,
    :re_order_purchase_indicator,
    :pick_up_address
  ]
end
