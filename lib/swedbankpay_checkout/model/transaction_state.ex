defmodule SwedbankpayCheckout.Model.TransactionState do
  @moduledoc """
  Initialized, Completed or Failed. Indicates the state of the transaction.
  """

  @type t :: :INITIALIZED | :COMPLETED | :FAILED

  def from_string(state) do
    case String.downcase(state) do
      "initialized" -> :INITIALIZED
      "completed" -> :COMPLETED
      "failed" -> :FAILED
      _ -> raise "invalid transaction state #{state}"
    end
  end
end
