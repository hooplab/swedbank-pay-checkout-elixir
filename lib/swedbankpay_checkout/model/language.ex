defmodule SwedbankpayCheckout.Model.Language do
  @type t :: :"sv-SE" | :"nb-NO" | :"en-US"

  @doc false
  def from_string(lang) do
    case String.downcase(lang) do
      "sv-se" -> :"sv-SE"
      "nb-no" -> :"nb-NO"
      "en-us" -> :"en-US"
      _ -> raise "invalid language code #{lang}"
    end
  end
end
