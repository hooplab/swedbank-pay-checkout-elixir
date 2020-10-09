defmodule SwedbankpayCheckout.Model.Payment do
  @moduledoc """
  """

  @typedoc """
    .payment
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :instrument => String.t(),
          :created => String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :id,
    :instrument,
    :created
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end