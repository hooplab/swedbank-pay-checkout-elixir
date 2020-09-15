defmodule SwedbankpayCheckout.Client.Psp.Consumers.PostResponse do
  @moduledoc """
  """

  @typedoc """
  Root response for initiating a checkin.

  See https://developer.swedbankpay.com/checkout/checkin
  """
  @type t :: %__MODULE__{
          :token => String.t(),
          :operations => [SwedbankpayCheckout.Model.Operation.t()]
        }

  defstruct [
    :token,
    :operations
  ]

  @doc false
  def shell() do
    %__MODULE__{
      operations: [SwedbankpayCheckout.Model.Operation.shell()]
    }
  end
end
