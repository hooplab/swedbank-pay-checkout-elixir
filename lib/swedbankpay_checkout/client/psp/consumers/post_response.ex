defmodule SwedbankpayCheckout.Client.Psp.Consumers.PostResponse do
  @moduledoc """
  HTTP/1.1 200 OK
  Content-Type: application/json

  {
    "token": "7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
    "operations": [
        {
            "method": "GET",
            "rel": "redirect-consumer-identification",
            "href": "https://ecom.externalintegration.payex.com/consumers/sessions/7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "rel": "view-consumer-identification",
            "href": "https://ecom.externalintegration.payex.com/consumers/core/scripts/client/px.consumer.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119",
            "contentType": "application/javascript"
        }
    ]
  }
  """
  @type t :: %__MODULE__{
          :token => String.t(),
          :operations => [SwedbankpayCheckout.Model.Operation.t()]
        }

  defstruct [
    :token,
    :operations
  ]

  def shell() do
    %__MODULE__{
      operations: [SwedbankpayCheckout.Model.Operation.shell()]
    }
  end
end
