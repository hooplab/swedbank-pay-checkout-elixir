defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.PaymentOrderResponse do
  @moduledoc """
  """

  @typedoc """
  .payment_order.operation
  """
  @type op :: :Purchase

  @typedoc """
    .payment_order
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :created => String.t(),
          :updated => String.t(),
          :operation => op,
          :state => SwedbankpayCheckout.Model.PaymentOrderState.t(),
          :currency => SwedbankpayCheckout.Model.Currency.t(),
          :amount => Integer.t(),
          :vat_amount => Integer.t(),
          :order_items =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.t(),
          :description => String.t() | nil,
          :initiating_system_user_agent => String.t(),
          :user_agent => String.t() | nil,
          :language => SwedbankpayCheckout.Model.Language.t(),
          :urls => SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.t(),
          :payee_info =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.t(),
          :payments => SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.t(),
          :current_payment =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.t(),
          :items => [SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.Item.t()]
        }
  @derive Poison.Encoder
  defstruct [
    :id,
    :created,
    :updated,
    :operation,
    :state,
    :currency,
    :amount,
    :vat_amount,
    :order_items,
    :description,
    :initiating_system_user_agent,
    :user_agent,
    :language,
    :urls,
    :payee_info,
    :payments,
    :current_payment,
    :items
  ]

  @doc false
  def shell() do
    %__MODULE__{
      order_items: SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.shell(),
      urls: SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.shell(),
      payee_info: SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.shell(),
      payments: SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.shell(),
      current_payment:
        SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.LoadableUrl.shell(),
      items: [SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.Item.shell()]
    }
  end
end

defimpl Poison.Decoder,
  for: SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse.PaymentOrderResponse do
  def decode(%{language: language, currency: currency, state: state} = payment_order_response, _) do
    %{
      payment_order_response
      | language: SwedbankpayCheckout.Model.Language.from_string(language),
        currency: SwedbankpayCheckout.Model.Currency.from_string(currency),
        state: SwedbankpayCheckout.Model.PaymentOrderState.from_string(state)
    }
  end
end
