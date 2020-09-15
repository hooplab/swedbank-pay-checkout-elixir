defmodule SwedbankpayCheckout.Client.Psp.Consumers do
  @moduledoc """
  consumer methods, require a `Tesla.Env.client()`, see `SwedbankpayCheckout.create_client/4`.
  """
  alias SwedbankpayCheckout.Client.Psp.Consumers
  alias SwedbankpayCheckout.Client.Helpers

  @doc """
  Create a consumer request, for displaying the checkin view.
  """
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
