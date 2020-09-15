defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.RiskIndicatorPickUpAddress do
  @moduledoc """
  """

  @typedoc """
  .payment_order.risk_indicator.pickup_address
  """
  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :street_address => String.t() | nil,
          :co_address => String.t() | nil,
          :city => String.t() | nil,
          :zip_code => String.t() | nil,
          :country_code => String.t() | nil
        }

  @derive Poison.Encoder
  defstruct [
    :name,
    :street_address,
    :co_address,
    :city,
    :zip_code,
    :country_code
  ]
end
