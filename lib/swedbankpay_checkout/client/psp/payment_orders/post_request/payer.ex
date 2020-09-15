defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.Payer do
  @moduledoc """
  """

  @typedoc """
  .payment_order.payer
  """
  @type t :: %__MODULE__{
          :consumer_profile_ref => String.t() | nil,
          :email => String.t() | nil,
          :msisdn => String.t() | nil,
          :work_phone_number => String.t() | nil,
          :home_phone_number => String.t() | nil
        }
  @derive Poison.Encoder
  defstruct [
    :consumer_profile_ref,
    :email,
    :msisdn,
    :work_phone_number,
    :home_phone_number
  ]
end
