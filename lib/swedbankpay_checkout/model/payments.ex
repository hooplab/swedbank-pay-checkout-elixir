defmodule SwedbankpayCheckout.Model.Payments do
  @moduledoc """
  """

  @typedoc """
    .payments
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :payment_list => []
        }
  @derive Poison.Encoder
  defstruct [
    :id,
    :payment_list
  ]

  @doc false
  def shell() do
    %__MODULE__{
      payment_list: [SwedbankpayCheckout.Model.Payment.shell()],
    }
  end
end