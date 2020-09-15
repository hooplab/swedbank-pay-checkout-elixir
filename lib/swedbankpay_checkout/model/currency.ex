defmodule SwedbankpayCheckout.Model.Currency do
  @type t :: :NOK

  @doc false
  def from_string(currency) do
    case String.downcase(currency) do
      "nok" -> :NOK
      _ -> raise "invalid currency code #{currency}"
    end
  end
end
