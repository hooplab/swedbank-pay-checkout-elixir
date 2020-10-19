defmodule SwedbankpayCheckout.Model.Payment do
  @moduledoc """
  """

  @typedoc """
    .payment_order
  """
  @type t :: %__MODULE__{
          :corporation_id => String.t(),
          :id => String.t(),
          :number => Integer.t(),
          :created => String.t(),
          :updated => String.t(),
          :instrument => String.t(),
          :operation => String.t(),
          :intent => String.t(),
          :state => String.t(),
          :currency => String.t(),
          :prices => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :amount => Integer.t(),
          :remaining_capture_amount => Integer.t(),
          :remaining_cancellation_amount => Integer.t(),
          :description => String.t(),
          :payer_reference => String.t(),
          :user_agent => String.t(),
          :language => String.t(),
          :transactions => SwedbankpayCheckout.Model.Transactions.t() | SwedbankpayCheckout.Model.LoadableUrl.t(),
          :authorizations => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :urls => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :payee_info => SwedbankpayCheckout.Model.LoadableUrl.t(),
          :metadata => SwedbankpayCheckout.Model.LoadableUrl.t(),
        }
  @derive Poison.Encoder
  defstruct [
    :corporation_id,
    :id,
    :number,
    :created,
    :updated,
    :instrument,
    :operation,
    :intent,
    :state,
    :currency,
    :prices,
    :amount,
    :remaining_capture_amount,
    :remaining_cancellation_amount,
    :description,
    :payer_reference,
    :user_agent,
    :language,
    :transactions,
    :authorizations,
    :urls,
    :payee_info,
    :metadata,
  ]

  @doc false
  def shell() do
    %__MODULE__{
      prices: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      transactions: SwedbankpayCheckout.Model.Transactions.shell(),
      authorizations: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      urls: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      payee_info: SwedbankpayCheckout.Model.LoadableUrl.shell(),
      metadata: SwedbankpayCheckout.Model.LoadableUrl.shell()
    }
  end
end

defimpl Poison.Decoder,
  for: SwedbankpayCheckout.Model.Payment do
  def decode(%{currency: currency, state: state} = payment_response, _) do
    %{
      payment_response
      | currency: SwedbankpayCheckout.Model.Currency.from_string(currency),
        state: SwedbankpayCheckout.Model.PaymentState.from_string(state)
    }
  end
end
