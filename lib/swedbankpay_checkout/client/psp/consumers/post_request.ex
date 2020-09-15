defmodule SwedbankpayCheckout.Client.Psp.Consumers.PostRequest do
  @moduledoc """
  """

  @typedoc """
  Root request for initiating a checkin.

  See https://developer.swedbankpay.com/checkout/checkin
  """
  @type t :: %__MODULE__{
          :operation => operation(),
          :language => SwedbankpayCheckout.Model.Language.t(),
          :shipping_address_restricted_to_country_codes => [String.t()]
        }

  @enforce_keys [
    :operation,
    :language,
    :shipping_address_restricted_to_country_codes
  ]
  @derive Poison.Encoder
  defstruct [
    :operation,
    :language,
    :shipping_address_restricted_to_country_codes
  ]

  @type operation :: :"initiate-consumer-session"
end
