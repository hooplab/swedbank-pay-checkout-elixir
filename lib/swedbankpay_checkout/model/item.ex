defmodule SwedbankpayCheckout.Model.Item do
  @moduledoc """
  """

  @typedoc """
  .payment_order.items
  """
  @type t :: %__MODULE__{
          :credit_card => SwedbankpayCheckout.Model.CreditCardItem.t()
        }
  @derive Poison.Encoder
  defstruct [
    :credit_card
  ]

  @doc false
  def shell() do
    %__MODULE__{
      credit_card: SwedbankpayCheckout.Model.CreditCardItem.shell()
    }
  end
end
