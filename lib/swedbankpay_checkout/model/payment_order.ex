defmodule SwedbankpayCheckout.Model.PaymentOrder do
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
          :remaining_capture_amount => Integer.t() | nil,
          :remaining_cancellation_amount => Integer.t() | nil,
          :order_items => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :description => String.t() | nil,
          :initiating_system_user_agent => String.t(),
          :user_agent => String.t() | nil,
          :language => SwedbankpayCheckout.Model.Language.t(),
          :urls => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :payee_info => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :payer => SwedbankpayCheckout.Model.Payer.t() | SwedbankpayCheckout.Model.LoadableUrl.t(),
          :payments => SwedbankpayCheckout.Model.Payments.t() | SwedbankpayCheckout.Model.LoadableUrl.t(),
          :current_payment => SwedbankpayCheckout.Model.CurrentPayment.t() | SwedbankpayCheckout.Model.LoadableUrl.t(),
          :items => [SwedbankpayCheckout.Model.Item.t()]
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
    :remaining_capture_amount,
    :remaining_cancellation_amount,
    :order_items,
    :description,
    :initiating_system_user_agent,
    :user_agent,
    :language,
    :urls,
    :payee_info,
    :payer,
    :payments,
    :current_payment,
    :items
  ]

  @doc false
  def shell() do
    %__MODULE__{
      order_items: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      urls: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      payee_info: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      payer: SwedbankpayCheckout.Model.Payer.shell(),
      payments: SwedbankpayCheckout.Model.Payments.shell(),
      current_payment: SwedbankpayCheckout.Model.CurrentPayment.shell(),
      items: [SwedbankpayCheckout.Model.Item.shell()]
    }
  end
end

defimpl Poison.Decoder,
  for: SwedbankpayCheckout.Model.PaymentOrder do
  def decode(%{language: language, currency: currency, state: state} = payment_order_response, _) do
    %{
      payment_order_response
      | language: SwedbankpayCheckout.Model.Language.from_string(language),
        currency: SwedbankpayCheckout.Model.Currency.from_string(currency),
        state: SwedbankpayCheckout.Model.PaymentOrderState.from_string(state)
    }
  end
end
