defmodule SwedbankpayCheckout.Client.Psp.Consumers.PostRequest do
  @moduledoc """
  POST /psp/consumers HTTP/1.1
  Host: api.externalintegration.payex.com
  Authorization: Bearer <AccessToken>
  Content-Type: application/json

  {
    "operation": "initiate-consumer-session",
    "language": "sv-SE",
    "shippingAddressRestrictedToCountryCodes" : ["NO", "SE", "DK"]
  }
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
