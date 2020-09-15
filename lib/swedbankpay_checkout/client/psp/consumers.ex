defmodule SwedbankpayCheckout.Client.Psp.Consumers do
  alias SwedbankpayCheckout.Client.Psp.Consumers
  alias SwedbankpayCheckout.Client.Helpers

  @spec post(Tesla.Client.t(), Consumers.PostRequest.t()) ::
          {:ok, Consumers.PostResponse.t()} | {:error, Tesla.Env.t()}
  def post(client, request_body) do
    Tesla.post(
      client,
      "/psp/consumers",
      request_body
    )
    |> Helpers.evaluate_response(%{
      200 => %{
        decode_as: Consumers.PostResponse.shell()
      }
    })
  end
end
