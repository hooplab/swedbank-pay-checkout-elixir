defmodule SwedbankpayCheckout do
  @moduledoc """
  Root module for creating clients.
  """

  @spec test_base_url :: String.t()
  def test_base_url, do: "https://api.externalintegration.payex.com/"
  @spec live_base_url :: String.t()
  def live_base_url, do: "https://api.payex.com/"

  @doc """
  Initializes a Tesla http client.
  Sets middlewares for base_url, authorization, user-agent: tesla and camelCase <> snake_case conversion
  as such these don't need to be included in additional_middleware

  adapter should be set to use a proper underlying http library, like mint or hackney

  By viewing this source it should be simple to create a custom tesla client.
  """
  @spec create_client(String.t(), String.t(), Tesla.Client.adapter(), [Tesla.Client.middleware()]) ::
          Tesla.Client.t()
  def create_client(base_url, access_token, adapter, additional_middleware \\ []) do
    middleware =
      [
        {
          Tesla.Middleware.BaseUrl,
          base_url
        },
        {
          Tesla.Middleware.Headers,
          [
            {"user-agent", "Tesla"},
            {"authorization", "Bearer #{access_token}"}
          ]
        },
        {Tesla.Middleware.JSON,
         decode: &SwedbankpayCheckout.Middleware.JsonUtil.decode_and_snake_case/1,
         encode: &SwedbankpayCheckout.Middleware.JsonUtil.encode_and_camelize/1}
      ] ++ additional_middleware

    Tesla.client(middleware, adapter)
  end
end
