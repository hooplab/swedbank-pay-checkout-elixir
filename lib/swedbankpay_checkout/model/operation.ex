defmodule SwedbankpayCheckout.Model.Operation do
  @type t :: %__MODULE__{
          :method => String.t(),
          :rel => String.t(),
          :href => String.t(),
          :content_type => String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :method,
    :rel,
    :href,
    :content_type
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
