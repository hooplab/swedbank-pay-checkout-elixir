defmodule SwedbankpayCheckout.Model.Payer do
  @moduledoc """
  """

  @typedoc """
    .payer
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :reference => String.t(),
          :name => String.t() | nil,
          :email => String.t(),
          :msisdn => String.t(),
          :gender => String.t() | nil,
          :birth_year => String.t() | nil,

          :shipping_address => SwedbankpayCheckout.Model.ShippingAddress.t() | SwedbankpayCheckout.Model.LoadableUrl.t(),
          :device => SwedbankpayCheckout.Model.Device.t() | SwedbankpayCheckout.Model.LoadableUrl.t(),
        }
  @derive Poison.Encoder
  defstruct [
    :id,
    :reference,
    :name,
    :email,
    :msisdn,
    :gender,
    :birth_year,
    :shipping_address,
    :device
  ]

  @doc false
  def shell() do
    %__MODULE__{
      shipping_address: SwedbankpayCheckout.Model.ShippingAddress.shell(),
      device: SwedbankpayCheckout.Model.Device.shell()
    }
  end
end