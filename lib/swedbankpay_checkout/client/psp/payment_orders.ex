defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders do
  @moduledoc """
  payment order methods, require a `Tesla.Env.client()`, see `SwedbankpayCheckout.create_client/4`.
  """
  alias SwedbankpayCheckout.Client.Psp.PaymentOrders
  alias SwedbankpayCheckout.Client.Helpers

  @doc """
  Create a payment order, for displaying the payment menu view.
  """
  @spec create_payment_order(Tesla.Env.client(), PaymentOrders.PostRequest.t()) ::
          {:ok, PaymentOrders.PostResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def create_payment_order(client, request_body) do
    Tesla.post(
      client,
      "/psp/paymentorders",
      request_body
    )
    |> Helpers.evaluate_response(%{
      201 => %{
        decode_as: PaymentOrders.RootResponse.shell()
      }
    })
  end

  @doc """
  Get a payment order, the payment_order_id should be the full id, with paths, not truncated to the UUID
  """
  @spec get_payment_order(Tesla.Env.client(), String.t()) ::
          {:ok, PaymentOrders.PostResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def get_payment_order(client, payment_order_id) do
    Tesla.get(
      client,
      payment_order_id
    )
    |> Helpers.evaluate_response(%{
      200 => %{
        decode_as: PaymentOrders.RootResponse.shell()
      }
    })
  end
end
