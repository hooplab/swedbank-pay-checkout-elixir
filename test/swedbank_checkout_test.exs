defmodule SwedbankpayCheckoutTest do
  use ExUnit.Case
  doctest SwedbankpayCheckout
  import Tesla.Mock
  require Logger

  defp create_client(),
    do:
      SwedbankpayCheckout.create_client(
        "http://bears.gov",
        "WITH_ARMS_WIDE_TOKAN",
        Tesla.Mock
      )

  test "client creation" do
    client = create_client()
    assert client != nil
  end

  test "POST consumer" do
    client = create_client()

    request_body = %SwedbankpayCheckout.Client.Psp.Consumers.PostRequest{
      operation: :"initiate-consumer-session",
      language: :"nb-NO",
      shipping_address_restricted_to_country_codes: ["NO"]
    }

    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares aswell
    mock(fn
      %{method: :post, url: "http://bears.gov/psp/consumers"} ->
        json(%{
          "token" => "7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
          "operations" => [
            %{
              "method" => "GET",
              "rel" => "redirect-consumer-identification",
              "href" =>
                "https://ecom.externalintegration.payex.com/consumers/sessions/7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
              "contentType" => "text/html"
            },
            %{
              "method" => "GET",
              "rel" => "view-consumer-identification",
              "href" =>
                "https://ecom.externalintegration.payex.com/consumers/core/scripts/client/px.consumer.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119",
              "contentType" => "application/javascript"
            }
          ]
        })
    end)

    resp = SwedbankpayCheckout.Client.Psp.Consumers.post(client, request_body)

    {:ok,
     %SwedbankpayCheckout.Client.Psp.Consumers.PostResponse{
       :token => token,
       :operations => operations
     }} = resp

    assert token == "7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871"

    [
      %SwedbankpayCheckout.Model.Operation{
        method: method1,
        href: href1,
        content_type: content_type1
      },
      %SwedbankpayCheckout.Model.Operation{
        method: method2,
        href: href2,
        content_type: content_type2
      }
    ] = operations

    assert method1 == "GET"
    assert method2 == "GET"

    assert href1 ==
             "https://ecom.externalintegration.payex.com/consumers/sessions/7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871" or
             href1 ==
               "https://ecom.externalintegration.payex.com/consumers/core/scripts/client/px.consumer.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119"

    assert href1 != href2

    assert content_type1 == "text/html" || content_type1 == "application/javascript"
    assert content_type1 != content_type2
  end

  defp mock_payment_order_response(method, url, status) do
    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares aswell
    mock(fn
      %{method: m, url: u} when m == method and u == url ->
        json(
          %{
            "paymentOrder" => %{
              "id" => "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
              "created" => "2020-06-22T10:56:56.2927632Z",
              "updated" => "2020-06-22T10:56:56.4035291Z",
              "operation" => "Purchase",
              "state" => "Ready",
              "currency" => "NOK",
              "amount" => 10000,
              "vatAmount" => 0,
              "orderItems" => %{
                "id" => "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/orderitems"
              },
              "description" => "test description",
              "initiatingSystemUserAgent" => "Mozilla/5.0",
              "userAgent" => "Mozilla/5.0",
              "language" => "nb-NO",
              "urls" => %{
                "id" => "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/urls"
              },
              "payeeInfo" => %{
                "id" => "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payeeInfo"
              },
              "payments" => %{
                "id" => "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payments"
              },
              "currentPayment" => %{
                "id" => "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/currentpayment"
              },
              "items" => [
                %{
                  "creditCard" => %{
                    "cardBrands" => [
                      "Visa",
                      "MasterCard"
                    ]
                  }
                }
              ]
            },
            "operations" => [
              %{
                "method" => "PATCH",
                "href" => "http://bears.gov/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
                "rel" => "update-paymentorder-updateorder",
                "contentType" => "application/json"
              },
              %{
                "method" => "PATCH",
                "href" => "http://bears.gov//paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
                "rel" => "update-paymentorder-abort",
                "contentType" => "application/json"
              },
              %{
                "method" => "PATCH",
                "href" => "http://bears.gov/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
                "rel" => "update-paymentorder-expandinstrument",
                "contentType" => "application/json"
              },
              %{
                "method" => "GET",
                "href" => "http://bears.gov/paymentmenu/5a17c24e-d459-4567-bbad-aa0f17a76119",
                "rel" => "redirect-paymentorder",
                "contentType" => "text/html"
              },
              %{
                "method" => "GET",
                "href" =>
                  "http://bears.gov/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119&culture=nb-NO",
                "rel" => "view-paymentorder",
                "contentType" => "application/javascript"
              },
              %{
                "method" => "POST",
                "href" =>
                  "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/captures",
                "rel" => "create-paymentorder-capture",
                "contentType" => "application/json"
              },
              %{
                "method" => "POST",
                "href" =>
                  "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/cancellations",
                "rel" => "create-paymentorder-cancel",
                "contentType" => "application/json"
              },
              %{
                "method" => "POST",
                "href" =>
                  "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/reversals",
                "rel" => "create-paymentorder-reversal",
                "contentType" => "application/json"
              }
            ]
          },
          status: status
        )
    end)
  end

  defp mock_payment_order_with_expand_response(method, url, status) do
    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares as well
    mock(fn
      %{method: m, url: u} when m == method and u == url ->
        json(
          %{
            "paymentOrder": %{
              "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
              "created": "2020-09-29T11:04:09.4831461Z",
              "updated": "2020-09-29T11:04:13.6839718Z",
              "operation": "Purchase",
              "state": "Ready",
              "currency": "NOK",
              "amount": 10000,
              "vatAmount": 0,
              "remainingCaptureAmount": 10000,
              "remainingCancellationAmount": 10000,
              "orderItems": %{
                "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/orderitems"
              },
              "description": "giftcard purchase",
              "initiatingSystemUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:80.0) Gecko/20100101 Firefox/80.0",
              "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:80.0) Gecko/20100101 Firefox/80.0",
              "language": "nb-NO",
              "urls": %{
                "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/urls"
              },
              "payeeInfo": %{
                "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payeeInfo"
              },
              "payer": %{
                "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payers",
                "reference": "377cc3cc-0453-4567-84c2-7c65014fc9d5",
                "name": "Olivia Nyhuus",
                "email": "olivia.nyhuus@payex.com",
                "msisdn": "+4798765432",
                "gender": "Female",
                "birthYear": "1967",
                "hashedFields": %{
                  "emailHash": "3fcd660b34968aa1be7647ec6d7527032de32ce5",
                  "msisdnHash": "9e4479f5a574272c3e439a0015e276a723b8b1a6",
                  "socialSecurityNumberHash": "2a56099d6d0b9b0f922e8eea6f31a14edf5a1873"
                },
                "shippingAddress": %{
                  "addressee": "Olivia Nyhuus",
                  "coAddress": "",
                  "streetAddress": "Eksempelgata 1",
                  "zipCode": "1642",
                  "city": "Oslo",
                  "countryCode": "NO"
                },
                "device": %{
                  "detectionAccuracy": 100,
                  "ipAddress": "85.19.212.202",
                  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:80.0) Gecko/20100101 Firefox/80.0",
                  "deviceType": "Desktop",
                  "hardwareFamily": "Macintosh",
                  "hardwareName": "Macintosh",
                  "hardwareVendor": "Apple",
                  "platformName": "macOS",
                  "platformVendor": "Apple",
                  "platformVersion": "10.15",
                  "browserName": "Firefox",
                  "browserVendor": "Mozilla",
                  "browserVersion": "80.0"
                }
              },
              "payments": %{
                "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/payments",
                "paymentList": [
                  %{
                    "id": "/psp/vipps/payments/d6f75c57-127c-4ba5-d313-08d8639bc1b4",
                    "instrument": "Vipps",
                    "created": "2020-09-29T11:04:13.7690375Z"
                  }
                ]
              },
              "currentPayment": %{
                "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/currentpayment"
              },
              "items": [
                %{
                  "creditCard": %{
                    "cardBrands": [
                      "Visa",
                      "MasterCard"
                    ]
                  }
                }
              ]
            },
            "operations": [
              %{
                "method": "POST",
                "href": "https://api.externalintegration.payex.com/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/cancellations",
                "rel": "create-paymentorder-cancel",
                "contentType": "application/json"
              },
              %{
                "method": "POST",
                "href": "https://api.externalintegration.payex.com/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/captures",
                "rel": "create-paymentorder-capture",
                "contentType": "application/json"
              },
              %{
                "method": "POST",
                "href": "https://api.externalintegration.payex.com/psp/vipps/payments/d6f75c57-127c-4ba5-d313-08d8639bc1b4/cancellations",
                "rel": "create-cancellation"
              },
              %{
                "method": "POST",
                "href": "https://api.externalintegration.payex.com/psp/vipps/payments/d6f75c57-127c-4ba5-d313-08d8639bc1b4/captures",
                "rel": "create-capture"
              },
              %{
                "method": "GET",
                "href": "https://ecom.externalintegration.payex.com/vipps/core/scripts/client/px.vipps.client.js?token=325fc5a2927a969c047c08dcee247263cee2459a639db5d6ff8e3eb8b85f3b03&Culture=nb-NO",
                "rel": "view-payment",
                "contentType": "application/javascript"
              },
              %{
                "method": "GET",
                "href": "https://api.externalintegration.payex.com/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/paid",
                "rel": "paid-paymentorder",
                "contentType": "application/json"
              }
            ]
          },
          status: status
        )
    end)
  end


  defp deep_assert_payment_order_response(
         {:ok,
          %SwedbankpayCheckout.Client.Psp.PaymentOrders.OrderResponse{
            :payment_order => payment_order,
            :operations => operations
          }}
       ) do
    # test all deep structures to make sure we are parsing them into structures correctly
    assert payment_order != nil
    assert payment_order.id == "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"
    assert hd(operations).method != nil
    assert payment_order.state == :READY
    assert payment_order.language == :"nb-NO"
    assert payment_order.currency == :NOK
    assert payment_order.amount == 10000
    assert payment_order.order_items.id != nil
    assert payment_order.urls.id != nil
    assert payment_order.payee_info.id != nil
    assert payment_order.payments.id != nil
    assert payment_order.current_payment.id != nil
    assert hd(payment_order.items).credit_card.card_brands != nil
    assert hd(payment_order.items).credit_card.card_brands != []
  end

    defp deep_assert_payment_order_response_expansion(
         {:ok,
          %SwedbankpayCheckout.Client.Psp.PaymentOrders.OrderResponse{
            :payment_order => payment_order,
            :operations => operations
          }}
       ) do
    # test all deep structures to make sure we are parsing them into structures correctly
    assert payment_order.payer.name === "Olivia Nyhuus"
    assert payment_order.payer.email === "olivia.nyhuus@payex.com"
    assert payment_order.payer.msisdn === "+4798765432"
    assert payment_order.payer.shipping_address.addressee === "Olivia Nyhuus"
    assert payment_order.payer.shipping_address.street_address === "Eksempelgata 1"
    assert payment_order.payer.device.ip_address === "85.19.212.202"
    assert payment_order.payer.device.detection_accuracy === 100

    assert is_list(payment_order.payments.payment_list)
    assert length(payment_order.payments.payment_list) === 1
    assert hd(payment_order.payments.payment_list).instrument === "Vipps"
  end

  test "POST payment_order" do
    client = create_client()

    mock_payment_order_response(:post, "http://bears.gov/psp/paymentorders", 201)

    request_body = %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest{
      payment_order:
        %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.PaymentOrderRequest{
          operation: :Purchase,
          currency: :NOK,
          amount: 1500,
          vat_amount: 375,
          description: "Test Purchase",
          user_agent: "Mozilla/1.0",
          language: :"nb-NO",
          instrument: nil,
          generate_recurrence_token: true,
          urls: %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.Urls{
            host_urls: ["https://hw.no", "https://tek.no"],
            complete_url: "https://example.com/payment-completed",
            cancel_url: "https://example.com/payment-canceled",
            payment_url: "https://example.com/perform-payment",
            callback_url: "https://api.example.com/payment-callback",
            terms_of_service_url: "https://example.com/termsandconditoons.pdf",
            logo_url: "https://example.com/logo.png"
          },
          payee_info: %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.PayeeInfo{
            payee_id: "5cabf558-5283-482f-b252-4d58e06f6f3b",
            payee_reference: "AB832",
            payee_name: "Merchant1",
            product_category: "A123",
            order_reference: "or-123456",
            subsite: "MySubsite"
          },
          payer: %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.Payer{
            consumer_profile_ref: "5a17c24e-d459-4567-bbad-aa0f17a76119",
            email: "olivia.nyhuus@payex.com",
            msisdn: "+4798765432",
            work_phone_number: "+4787654321",
            home_phone_number: "+4776543210"
          },
          order_items: %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem{
            reference: "P1",
            name: "Product1",
            type: :PRODUCT,
            class: "ProductGroup1",
            item_url: "https://example.com/products/123",
            image_url: "https://example.com/product123.jpg",
            description: "Product 1 description",
            discount_description: "Volume discount",
            quantity: 4,
            quantity_unit: "pcs",
            unit_price: 300,
            discount_price: 200,
            vat_percent: 2500,
            amount: 1000,
            vat_amount: 250
          },
          risk_indicator: %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.RiskIndicator{
            delivery_email_address: "olivia.nyhuus@payex.com",
            delivery_time_frame_indicator: "01",
            pre_order_date: "19801231",
            pre_order_purchase_indicator: "01",
            ship_indicator: "01",
            gift_card_purchase: false,
            re_order_purchase_indicator: "01"
          }
        }
    }

    resp = SwedbankpayCheckout.Client.Psp.PaymentOrders.create_payment_order(client, request_body)

    deep_assert_payment_order_response(resp)
  end

  test "GET payment_order" do
    client = create_client()

    id = "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"

    mock_payment_order_response(
      :get,
      "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce?$expand=",
      200
    )

    resp =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order(
        client,
        id
      )

    deep_assert_payment_order_response(resp)
  end

  test "GET payment_order with expand" do
    client = create_client()

    id = "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"

    mock_payment_order_with_expand_response(
      :get,
      "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce?$expand=payer,payments",
      200
    )

    resp =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order(
        client,
        id,
        [:payer, :payments]
      )

    deep_assert_payment_order_response(resp)
    deep_assert_payment_order_response_expansion(resp)
  end

  test "POST cancellation" do
    client = create_client()
    id = "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"

    mock_payment_order_response(
      :get,
      "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce?$expand=",
      200
    )

    {:ok, order_response} =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order(
        client,
        id
      )

    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares aswell
    mock(fn
      %{
        method: :post,
        url:
          "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/cancellations"
      } ->
        json(
          %{
            "payment" => "/psp/paymentorders/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1",
            "cancellation" => %{
              "id" =>
                "/psp/paymentorders/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/cancellations/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
              "transaction" => %{
                "id" =>
                  "/psp/paymentorders/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/transactions/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
                "type" => "Cancel",
                "state" => "Completed",
                "amount" => 5610,
                "vatAmount" => 1122,
                "description" => "Cancelling parts of the authorized payment",
                "payeeReference" => "AB832"
              }
            }
          },
          status: 200
        )
    end)

    request_body = %SwedbankpayCheckout.Client.Psp.PaymentOrders.CancelRequest{
      payee_reference: "AB832",
      description: "Cancelling parts of the authorized payment"
    }

    {:ok, cancel_response} =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.cancel_payment_order(
        client,
        order_response,
        request_body
      )

    assert cancel_response.cancellation.transaction.amount == 5610
  end

  test "POST capture" do
    client = create_client()
    id = "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"

    mock_payment_order_response(
      :get,
      "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce?$expand=",
      200
    )

    {:ok, order_response} =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order(
        client,
        id
      )

    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares aswell
    mock(fn
      %{
        method: :post,
        url: "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/captures"
      } ->
        json(
          %{
            "payment" => "/psp/paymentorders/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1",
            "capture" => %{
              "id" =>
                "/psp/paymentorders/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/captures/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
              "transaction" => %{
                "id" =>
                  "/psp/paymentorders/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/transactions/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
                "type" => "Capture",
                "state" => "Completed",
                "amount" => 15610,
                "vatAmount" => 3122,
                "description" => "Capturing the authorized payment",
                "payeeReference" => "AB832",
                "receiptReference" => "AB831"
              }
            }
          },
          status: 200
        )
    end)

    request_body = %SwedbankpayCheckout.Client.Psp.PaymentOrders.CaptureRequest{
      transaction: %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionRequest{
        description: "Capturing the authorized payment",
        amount: 1500,
        vat_amount: 375,
        payee_reference: "AB832",
        receipt_reference: "AB831",
        order_items: [
          %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem{
            reference: "P1",
            name: "Product1",
            type: "PRODUCT",
            class: "ProductGroup1",
            item_url: "https://example.com/products/123",
            image_url: "https://example.com/product123.jpg",
            description: "Product 1 description",
            discount_description: "Volume discount",
            quantity: 4,
            quantity_unit: "pcs",
            unit_price: 300,
            discount_price: 200,
            vat_percent: 2500,
            amount: 1000,
            vat_amount: 250
          },
          %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem{
            reference: "P2",
            name: "Product2",
            type: "PRODUCT",
            class: "ProductGroup1",
            description: "Product 2 description",
            quantity: 1,
            quantity_unit: "pcs",
            unit_price: 500,
            vat_percent: 2500,
            amount: 500,
            vat_amount: 125
          }
        ]
      }
    }

    {:ok, capture_response} =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.capture_payment_order(
        client,
        order_response,
        request_body
      )

    assert capture_response.capture.transaction.amount == 15610
  end

  test "POST reversal" do
    client = create_client()
    id = "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"

    mock_payment_order_response(
      :get,
      "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce?$expand=",
      200
    )

    {:ok, order_response} =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order(
        client,
        id
      )

    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares aswell
    mock(fn
      %{
        method: :post,
        url: "http://bears.gov/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce/reversals"
      } ->
        json(
          %{
            payment: "/psp/paymentorders/payments/09ccd29a-7c4f-4752-9396-12100cbfecce",
            reversals: %{
              id:
                "/psp/paymentorders/payments/09ccd29a-7c4f-4752-9396-12100cbfecce/cancellations/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
              transaction: %{
                id:
                  "/psp/paymentorders/payments/09ccd29a-7c4f-4752-9396-12100cbfecce/transactions/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
                type: "Reversal",
                state: "Completed",
                amount: 15610,
                vat_amount: 3122,
                description: "Reversing the capture amount",
                payee_reference: "ABC987",
                receipt_reference: "ABC986"
              }
            }
          },
          status: 200
        )
    end)

    request_body = %SwedbankpayCheckout.Client.Psp.PaymentOrders.ReverseRequest{
      transaction: %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.TransactionRequest{
        description: "Capturing the authorized payment",
        amount: 1500,
        vat_amount: 375,
        payee_reference: "AB832",
        receipt_reference: "AB831",
        order_items: [
          %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem{
            reference: "P1",
            name: "Product1",
            type: "PRODUCT",
            class: "ProductGroup1",
            item_url: "https://example.com/products/123",
            image_url: "https://example.com/product123.jpg",
            description: "Product 1 description",
            discount_description: "Volume discount",
            quantity: 4,
            quantity_unit: "pcs",
            unit_price: 300,
            discount_price: 200,
            vat_percent: 2500,
            amount: 1000,
            vat_amount: 250
          },
          %SwedbankpayCheckout.Client.Psp.PaymentOrders.Common.OrderItem{
            reference: "P2",
            name: "Product2",
            type: "PRODUCT",
            class: "ProductGroup1",
            description: "Product 2 description",
            quantity: 1,
            quantity_unit: "pcs",
            unit_price: 500,
            vat_percent: 2500,
            amount: 500,
            vat_amount: 125
          }
        ]
      }
    }

    {:ok, reversal_response} =
      SwedbankpayCheckout.Client.Psp.PaymentOrders.reverse_payment_order(
        client,
        order_response,
        request_body
      )

    assert reversal_response.reversals.transaction.amount == 15610
  end
end
