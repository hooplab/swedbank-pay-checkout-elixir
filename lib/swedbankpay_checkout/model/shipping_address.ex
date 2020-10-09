defmodule SwedbankpayCheckout.Model.ShippingAddress do
  @moduledoc """
  """

  @typedoc """
    .shipping_address
  """
  @type t :: %__MODULE__{
          :addressee => String.t(),
          :co_address => String.t(),
          :street_address => String.t(),
          :zip_code => String.t(),
          :city => String.t(),
          :country_code => String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :addressee,
    :co_address,
    :street_address,
    :zip_code,
    :city,
    :country_code
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
