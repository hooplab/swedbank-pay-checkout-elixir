defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest do
  @moduledoc """
  POST /psp/paymentorders HTTP/1.1
  Host: api.externalintegration.payex.com
  Authorization: Bearer <AccessToken>
  Content-Type: application/json

  {
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "instrument": "CreditCard"
        "generateRecurrenceToken": false,
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf",
            "logoUrl": "https://example.com/logo.png"
        },
        "payeeInfo": {
            "payeeId": "5cabf558-5283-482f-b252-4d58e06f6f3b",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "payer": {
            "consumerProfileRef": "5a17c24e-d459-4567-bbad-aa0f17a76119",
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "workPhoneNumber" : "+4787654321",
            "homePhoneNumber" : "+4776543210"
        },
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "I1",
                "name": "InvoiceFee",
                "type": "PAYMENT_FEE",
                "class": "Fees",
                "description": "Fee for paying with Invoice",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 1900,
                "vatPercent": 0,
                "amount": 1900,
                "vatAmount": 0,
            }
        ],
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Olivia Nyhus",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }
        }
    }
  }
  """

  @type t :: %__MODULE__{
          :payment_order => SwedbankpayCheckout.Client.Psp.PaymentOrders.PaymentOrderRequest.t()
        }

  @enforce_keys [:payment_order]
  @derive Poison.Encoder
  defstruct [
    :payment_order
  ]
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PaymentOrderRequest do
  @moduledoc """
  {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 375,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "instrument": "CreditCard"
    "generateRecurrenceToken": false,
    "urls": { ... },
    "payeeInfo": { ... },
    "payer": { ... },
    "orderItems": [ ... ],
    "riskIndicator": { ... },
  }
  """

  @type op :: :Purchase

  @type t :: %__MODULE__{
          :operation => op,
          :currency => SwedbankpayCheckout.Model.Currency.t(),
          :amount => Integer.t(),
          :vat_amount => Integer.t(),
          :description => String.t() | nil,
          :instrument => String.t() | nil,
          :generate_recurrence_token => boolean(),
          :user_agent => String.t(),
          :language => SwedbankpayCheckout.Model.Language.t(),
          :urls => SwedbankpayCheckout.Client.Psp.PaymentOrders.Urls.t(),
          :payee_info => SwedbankpayCheckout.Client.Psp.PaymentOrders.PayeeInfo.t(),
          :payer => SwedbankpayCheckout.Client.Psp.PaymentOrders.Payer.t(),
          :order_items => [SwedbankpayCheckout.Client.Psp.PaymentOrders.OrderItem.t()],
          :risk_indicator => SwedbankpayCheckout.Client.Psp.PaymentOrders.RiskIndicator.t() | nil
        }
  @enforce_keys [
    :operation,
    :currency,
    :amount,
    :vat_amount,
    :generate_recurrence_token,
    :user_agent,
    :language,
    :instrument,
    :urls,
    :payee_info,
    :payer,
    :order_items
  ]
  @derive Poison.Encoder
  defstruct [
    :operation,
    :currency,
    :amount,
    :vat_amount,
    :description,
    :user_agent,
    :language,
    :instrument,
    :generate_recurrence_token,
    :urls,
    :payee_info,
    :payer,
    :order_items,
    :risk_indicator
  ]
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.Urls do
  @moduledoc """
  {
    "hostUrls": [ "https://example.com", "https://example.net" ],
    "completeUrl": "https://example.com/payment-completed",
    "cancelUrl": "https://example.com/payment-canceled",
    "paymentUrl": "https://example.com/perform-payment",
    "callbackUrl": "https://api.example.com/payment-callback",
    "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf",
    "logoUrl": "https://example.com/logo.png"
  }
  """

  @type t :: %__MODULE__{
          :host_urls => [String.t()],
          :complete_url => String.t(),
          :cancel_url => String.t() | nil,
          :payment_url => String.t() | nil,
          :callback_url => String.t(),
          :terms_of_service_url => String.t(),
          :logo_url => String.t() | nil
        }
  @enforce_keys [
    :host_urls,
    :complete_url,
    :callback_url,
    :terms_of_service_url
  ]
  @derive Poison.Encoder
  defstruct [
    :host_urls,
    :complete_url,
    :cancel_url,
    :payment_url,
    :callback_url,
    :terms_of_service_url,
    :logo_url
  ]
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.PayeeInfo do
  @moduledoc """
  {
    "payeeId": "5cabf558-5283-482f-b252-4d58e06f6f3b",
    "payeeReference": "AB832",
    "payeeName": "Merchant1",
    "productCategory": "A123",
    "orderReference": "or-123456",
    "subsite": "MySubsite"
  }
  """
  @type t :: %__MODULE__{
          :payee_id => String.t(),
          :payee_reference => String.t(),
          :payee_name => String.t() | nil,
          :product_category => String.t() | nil,
          :order_reference => String.t() | nil,
          :subsite => String.t() | nil
        }
  @enforce_keys [
    :payee_id,
    :payee_reference
  ]
  @derive Poison.Encoder
  defstruct [
    :payee_id,
    :payee_reference,
    :payee_name,
    :product_category,
    :order_reference,
    :subsite
  ]
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.Payer do
  @moduledoc """
  {
    "consumerProfileRef": "5a17c24e-d459-4567-bbad-aa0f17a76119",
    "email": "olivia.nyhuus@payex.com",
    "msisdn": "+4798765432",
    "workPhoneNumber" : "+4787654321",
    "homePhoneNumber" : "+4776543210"
  }
  """
  @type t :: %__MODULE__{
          :consumer_profile_ref => String.t() | nil,
          :email => String.t() | nil,
          :msisdn => String.t() | nil,
          :work_phone_number => String.t() | nil,
          :home_phone_number => String.t() | nil
        }
  @derive Poison.Encoder
  defstruct [
    :consumer_profile_ref,
    :email,
    :msisdn,
    :work_phone_number,
    :home_phone_number
  ]
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.OrderItem do
  @moduledoc """
  {
    "reference": "P1",
    "name": "Product1",
    "type": "PRODUCT",
    "class": "ProductGroup1",
    "itemUrl": "https://example.com/products/123",
    "imageUrl": "https://example.com/product123.jpg",
    "description": "Product 1 description",
    "discountDescription": "Volume discount",
    "quantity": 4,
    "quantityUnit": "pcs",
    "unitPrice": 300,
    "discountPrice": 200,
    "vatPercent": 2500,
    "amount": 1000,
    "vatAmount": 250
  }
  """
  @type order_item_type ::
          :PRODUCT | :SERVICE | :SHIPPING_FEE | :PAYMENT_FEE | :DISCOUNT | :VALUE_CODE | :OTHER

  @type t :: %__MODULE__{
          :reference => String.t(),
          :name => String.t(),
          :type => order_item_type(),
          :class => String.t(),
          :item_url => String.t() | nil,
          :image_url => String.t() | nil,
          :description => String.t() | nil,
          :discount_description => String.t() | nil,
          :quantity => integer(),
          :quantity_unit => String.t(),
          :unit_price => integer(),
          :discount_price => integer() | nil,
          :vat_percent => integer(),
          :amount => integer(),
          :vat_amount => integer()
        }
  @enforce_keys [
    :reference,
    :name,
    :type,
    :class,
    :quantity,
    :quantity_unit,
    :unit_price,
    :vat_percent,
    :amount,
    :vat_amount
  ]
  @derive Poison.Encoder
  defstruct [
    :reference,
    :name,
    :type,
    :class,
    :item_url,
    :image_url,
    :description,
    :discount_description,
    :quantity,
    :quantity_unit,
    :unit_price,
    :discount_price,
    :vat_percent,
    :amount,
    :vat_amount
  ]
end

# TODO: use more refined types that strings for these dates and magic numbers
defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.RiskIndicator do
  @moduledoc """
  {
      "deliveryEmailAddress": "olivia.nyhuus@payex.com",
      "deliveryTimeFrameIndicator": "01",
      "preOrderDate": "19801231",
      "preOrderPurchaseIndicator": "01",
      "shipIndicator": "01",
      "giftCardPurchase": false,
      "reOrderPurchaseIndicator": "01",
      "pickUpAddress": {
          "name": "Olivia Nyhus",
          "streetAddress": "Saltnestoppen 43",
          "coAddress": "",
          "city": "Saltnes",
          "zipCode": "1642",
          "countryCode": "NO"
      }
  }
  """

  @type t :: %__MODULE__{
          :delivery_email_address => String.t() | nil,
          :delivery_time_frame_indicator => String.t() | nil,
          :pre_order_date => String.t() | nil,
          :pre_order_purchase_indicator => String.t() | nil,
          :ship_indicator => String.t() | nil,
          :gift_card_purchase => boolean() | nil,
          :re_order_purchase_indicator => String.t() | nil,
          :pick_up_address =>
            SwedbankpayCheckout.Client.Psp.PaymentOrders.RiskIndicatorPickUpAddress.t() | nil
        }

  @derive Poison.Encoder
  defstruct [
    :delivery_email_address,
    :delivery_time_frame_indicator,
    :pre_order_date,
    :pre_order_purchase_indicator,
    :ship_indicator,
    :gift_card_purchase,
    :re_order_purchase_indicator,
    :pick_up_address
  ]
end

defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders.RiskIndicatorPickUpAddress do
  @moduledoc """
  {
    "name": "Olivia Nyhus",
    "streetAddress": "Saltnestoppen 43",
    "coAddress": "",
    "city": "Saltnes",
    "zipCode": "1642",
    "countryCode": "NO"
  }
  """
  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :street_address => String.t() | nil,
          :co_address => String.t() | nil,
          :city => String.t() | nil,
          :zip_code => String.t() | nil,
          :country_code => String.t() | nil
        }

  @derive Poison.Encoder
  defstruct [
    :name,
    :street_address,
    :co_address,
    :city,
    :zip_code,
    :country_code
  ]
end
