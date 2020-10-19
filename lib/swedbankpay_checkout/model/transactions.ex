defmodule SwedbankpayCheckout.Model.Transactions do
  @moduledoc """
  """

  @typedoc """
    .payments
  """
  @type t :: %__MODULE__{
          :id => String.t(),
          :transaction_list => []
        }
  @derive Poison.Encoder
  defstruct [
    :id,
    :transaction_list
  ]

  @doc false
  def shell() do
    %__MODULE__{
      transaction_list: [SwedbankpayCheckout.Model.Transaction.shell()],
    }
  end
end