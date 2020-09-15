defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders do
  @moduledoc """
  payment order methods, require a `Tesla.Env.client()`, see `SwedbankpayCheckout.create_client/4`.
  """
  alias SwedbankpayCheckout.Client.Psp.PaymentOrders
  alias SwedbankpayCheckout.Client.Helpers

  @doc """
  Create a payment order, for displaying the payment menu view.
  """
  @spec post(Tesla.Env.client(), PaymentOrders.PostRequest.t()) ::
          {:ok, PaymentOrders.PostResponse.t()} | {:error, Tesla.Env.t()}
  def post(client, request_body) do
    Tesla.post(
      client,
      "/psp/paymentorders",
      request_body
    )
    |> Helpers.evaluate_response(%{
      201 => %{
        decode_as: PaymentOrders.PostResponse.shell()
      }
    })
  end
end
