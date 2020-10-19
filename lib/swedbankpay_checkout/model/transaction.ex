defmodule SwedbankpayCheckout.Model.Transaction do
  @moduledoc """
  """

  @typedoc """
    .payment_order
  """
  @type t :: %__MODULE__{
               :id => String.t(),
               :created => String.t(),
               :updated => String.t(),
               :type => String.t(),
               :state => String.t(),
               :number => Integer.t(),
               :amount => Integer.t(),
               :vat_amount => Integer.t(),
               :description => String.t(),
               :payer_reference => String.t(),
               :is_operational => Boolean.t(),
               :operations => []
             }
  @derive Poison.Encoder
  defstruct [
    :id,
    :created,
    :updated,
    :type,
    :state,
    :number,
    :amount,
    :vat_amount,
    :description,
    :payer_reference,
    :is_operational,
    :operations
  ]

  @doc false
  def shell() do
    %__MODULE__{}
  end
end

defimpl Poison.Decoder,
        for: SwedbankpayCheckout.Model.Transaction do
  def decode(%{state: state} = transaction_response, _) do
    %{
      transaction_response
    | state: SwedbankpayCheckout.Model.TransactionState.from_string(state)
    }
  end
end
