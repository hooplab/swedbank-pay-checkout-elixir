defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.OrderItem do
  @moduledoc """
  """

  @typedoc """
  .payment_order.order_item.type
  """
  @type order_item_type ::
          :PRODUCT | :SERVICE | :SHIPPING_FEE | :PAYMENT_FEE | :DISCOUNT | :VALUE_CODE | :OTHER

  @typedoc """
  .payment_order.order_item
  """
  @type t :: %__MODULE__{
          :reference => String.t(),
          :name => String.t(),
          :type => order_item_type(),
          :class => String.t(),
          :item_url => String.t() | nil,
          :image_url => String.t() | nil,
          :description => String.t() | nil,
          :discount_description => String.t() | nil,
          :quantity => integer(),
          :quantity_unit => String.t(),
          :unit_price => integer(),
          :discount_price => integer() | nil,
          :vat_percent => integer(),
          :amount => integer(),
          :vat_amount => integer()
        }
  @enforce_keys [
    :reference,
    :name,
    :type,
    :class,
    :quantity,
    :quantity_unit,
    :unit_price,
    :vat_percent,
    :amount,
    :vat_amount
  ]
  @derive Poison.Encoder
  defstruct [
    :reference,
    :name,
    :type,
    :class,
    :item_url,
    :image_url,
    :description,
    :discount_description,
    :quantity,
    :quantity_unit,
    :unit_price,
    :discount_price,
    :vat_percent,
    :amount,
    :vat_amount
  ]
end
