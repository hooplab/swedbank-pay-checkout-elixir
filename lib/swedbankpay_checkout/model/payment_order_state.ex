defmodule SwedbankpayCheckout.Model.PaymentOrderState do
  @moduledoc """
  Ready, Pending, Failed or Aborted. Indicates the state of the payment order.
  Does not reflect the state of any ongoing payments initiated from the payment order.
  This field is only for status display purposes.
  """

  @type t :: :READY | :PENDING | :FAILED | :ABORTED

  def from_string(state) do
    case String.downcase(state) do
      "ready" -> :READY
      "pending" -> :PENDING
      "failed" -> :FAILED
      "aborted" -> :ABORTED
      _ -> raise "invalid payment order state #{state}"
    end
  end
end
