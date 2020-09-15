defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostResponse do
  @moduledoc """
  POST /psp/paymentorders HTTP/1.1
  Host: api.externalintegration.payex.com
  Authorization: Bearer <AccessToken>
  Content-Type: application/json

  {
    "paymentOrder": {
        "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 0,
        "orderItems": {
            "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/orderitems"
        },
        "description": "test description",
        "initiatingSystemUserAgent": "Mozilla/5.0",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payeeInfo"
        },
        "payments": {
            "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payments"
        },
        "currentPayment": {
            "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/currentpayment"
        },
        "items": [
            {
                "creditCard": {
                    "cardBrands": [
                        "Visa",
                        "MasterCard"
                    ]
                }
            }
        ]
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://ecom.externalintegration.payex.com/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://ecom.externalintegration.payex.com/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
            "rel": "update-paymentorder-expandinstrument",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/5a17c24e-d459-4567-bbad-aa0f17a76119",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
  }
  """

  @type t :: %__MODULE__{
          :payment_order => SwedbankpayCheckout.Client.Psp.PaymentOrders.PaymentOrderResponse.t(),
          :operations => [SwedbankpayCheckout.Model.Operation.t()]
        }

  @derive Poison.Encoder
  defstruct [
    :payment_order,
    :operations
  ]

  def shell() do
    %__MODULE__{
      payment_order: SwedbankpayCheckout.Client.Psp.PaymentOrders.PaymentOrderResponse.shell(),
      operations: [SwedbankpayCheckout.Model.Operation.shell()]
    }
  end
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PaymentOrderResponse do
  @moduledoc """
  {
    "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
    "created": "2020-06-22T10:56:56.2927632Z",
    "updated": "2020-06-22T10:56:56.4035291Z",
    "operation": "Purchase",
    "state": "Ready",
    "currency": "SEK",
    "amount": 10000,
    "vatAmount": 0,
    "orderItems": {
        "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/orderitems"
    },
    "description": "test description",
    "initiatingSystemUserAgent": "Mozilla/5.0",
    "userAgent": "Mozilla/5.0",
    "language": "sv-SE",
    "urls": {
        "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/urls"
    },
    "payeeInfo": {
        "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payeeInfo"
    },
    "payments": {
        "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payments"
    },
    "currentPayment": {
        "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/currentpayment"
    },
    "items": [
        {
            "creditCard": {
                "cardBrands": [
                    "Visa",
                    "MasterCard"
                ]
            }
        }
    ]
    }
  """

  @type op :: :Purchase

  @type t :: %__MODULE__{
          :id => String.t(),
          :created => String.t(),
          :updated => String.t(),
          :operation => op,
          :state => SwedbankpayCheckout.Model.PaymentOrderState.t(),
          :currency => SwedbankpayCheckout.Model.Currency.t(),
          :amount => Integer.t(),
          :vat_amount => Integer.t(),
          :order_items => SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.t(),
          :description => String.t() | nil,
          :initiating_system_user_agent => String.t(),
          :user_agent => String.t() | nil,
          :language => SwedbankpayCheckout.Model.Language.t(),
          :urls => SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.t(),
          :payee_info => SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.t(),
          :payments => SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.t(),
          :current_payment => SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.t(),
          :items => [SwedbankpayCheckout.Client.Psp.PaymentOrders.Item.t()]
        }
  @derive Poison.Encoder
  defstruct [
    :id,
    :created,
    :updated,
    :operation,
    :state,
    :currency,
    :amount,
    :vat_amount,
    :order_items,
    :description,
    :initiating_system_user_agent,
    :user_agent,
    :language,
    :urls,
    :payee_info,
    :payments,
    :current_payment,
    :items
  ]

  def shell() do
    %__MODULE__{
      order_items: SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.shell(),
      urls: SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.shell(),
      payee_info: SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.shell(),
      payments: SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.shell(),
      current_payment: SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl.shell(),
      items: [SwedbankpayCheckout.Client.Psp.PaymentOrders.Item.shell()]
    }
  end
end

defimpl Poison.Decoder, for: SwedbankpayCheckout.Client.Psp.PaymentOrders.PaymentOrderResponse do
  def decode(%{language: language, currency: currency, state: state} = payment_order_response, _) do
    %{
      payment_order_response
      | language: SwedbankpayCheckout.Model.Language.from_string(language),
        currency: SwedbankpayCheckout.Model.Currency.from_string(currency),
        state: SwedbankpayCheckout.Model.PaymentOrderState.from_string(state)
    }
  end
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.LoadableUrl do
  @moduledoc """
  {
    "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/orderitems"
  }
  """

  @type t :: %__MODULE__{
          :id => String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :id
  ]

  def shell(), do: %__MODULE__{}
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.Item do
  @moduledoc """
  {
    "creditCard": {
        "cardBrands": [
            "Visa",
            "MasterCard"
        ]
    }
  }
  """

  @type t :: %__MODULE__{
          :credit_card => SwedbankpayCheckout.Client.Psp.PaymentOrders.CreditCardItem.t()
        }
  @derive Poison.Encoder
  defstruct [
    :credit_card
  ]

  def shell() do
    %__MODULE__{
      credit_card: SwedbankpayCheckout.Client.Psp.PaymentOrders.CreditCardItem.shell()
    }
  end
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.CreditCardItem do
  @moduledoc """
  {
      "cardBrands": [
          "Visa",
          "MasterCard"
      ]
  }
  """

  @type t :: %__MODULE__{
          :card_brands => [String.t()]
        }
  @derive Poison.Encoder
  defstruct [
    :card_brands
  ]

  def shell(), do: %__MODULE__{}
end
