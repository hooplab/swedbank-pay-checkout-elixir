defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.Urls do
  @moduledoc """
  """

  @typedoc """
  .payment_order.urls
  """
  @type t :: %__MODULE__{
          :host_urls => [String.t()],
          :complete_url => String.t(),
          :cancel_url => String.t() | nil,
          :payment_url => String.t() | nil,
          :callback_url => String.t(),
          :terms_of_service_url => String.t(),
          :logo_url => String.t() | nil
        }
  @enforce_keys [
    :host_urls,
    :complete_url,
    :callback_url,
    :terms_of_service_url
  ]
  @derive Poison.Encoder
  defstruct [
    :host_urls,
    :complete_url,
    :cancel_url,
    :payment_url,
    :callback_url,
    :terms_of_service_url,
    :logo_url
  ]
end
