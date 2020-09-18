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

  test "parsing the example post consumers response" do
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

  test "parsing the example post payment order response" do
    client = create_client()

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
          order_items: %SwedbankpayCheckout.Client.Psp.PaymentOrders.PostRequest.OrderItem{
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

    # this is in camelcase, as this is what the api we are mocking _actually_ returns, as such we test our middlewares aswell
    mock(fn
      %{method: :post, url: "http://bears.gov/psp/paymentorders"} ->
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
                "href" =>
                  "https://ecom.externalintegration.payex.com/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
                "rel" => "update-paymentorder-updateorder",
                "contentType" => "application/json"
              },
              %{
                "method" => "PATCH",
                "href" =>
                  "https://api.externalintegration.payex.com/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
                "rel" => "update-paymentorder-abort",
                "contentType" => "application/json"
              },
              %{
                "method" => "PATCH",
                "href" =>
                  "https://ecom.externalintegration.payex.com/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce",
                "rel" => "update-paymentorder-expandinstrument",
                "contentType" => "application/json"
              },
              %{
                "method" => "GET",
                "href" =>
                  "https://ecom.externalintegration.payex.com/paymentmenu/5a17c24e-d459-4567-bbad-aa0f17a76119",
                "rel" => "redirect-paymentorder",
                "contentType" => "text/html"
              },
              %{
                "method" => "GET",
                "href" =>
                  "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119&culture=nb-NO",
                "rel" => "view-paymentorder",
                "contentType" => "application/javascript"
              }
            ]
          },
          status: 201
        )
    end)

    resp = SwedbankpayCheckout.Client.Psp.PaymentOrders.create_payment_order(client, request_body)

    Logger.debug(inspect(resp, pretty: true))

    {:ok,
     %SwedbankpayCheckout.Client.Psp.PaymentOrders.RootResponse{
       :payment_order => payment_order,
       :operations => operations
     }} = resp

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
end
