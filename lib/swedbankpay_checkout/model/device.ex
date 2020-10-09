defmodule SwedbankpayCheckout.Model.Device do
  @moduledoc """
  """

  @typedoc """
    .device
  """
  @type t :: %__MODULE__{
          :detection_accuracy => Integer.t(),
          :ip_address => String.t(),
          :user_agent => String.t(),
          :device_type => String.t(),
          :hardware_family => String.t(),
          :hardware_name => String.t(),
          :hardware_vendor => String.t(),
          :platform_name => String.t(),
          :platform_vendor => String.t(),
          :platform_version => String.t(),
          :browser_name => String.t(),
          :browser_vendor => String.t(),
          :browser_version => String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :detection_accuracy,
    :ip_address,
    :user_agent,
    :device_type,
    :hardware_family,
    :hardware_name,
    :hardware_vendor,
    :platform_name,
    :platform_vendor,
    :platform_version,
    :browser_name,
    :browser_vendor,
    :browser_version
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
