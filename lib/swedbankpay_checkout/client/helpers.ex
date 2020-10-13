defmodule SwedbankpayCheckout.Client.Helpers do
  @moduledoc false

  require Logger

  def evaluate_response({:ok, %Tesla.Env{status: status, body: body} = env}, mapping) do
    Logger.debug(inspect(body, pretty: true))
    Logger.debug(inspect(mapping, pretty: true))

    case mapping[status] do
      %{decode_as: decode_as} ->
        {:ok, Poison.Decode.transform(body, %{as: decode_as})}

      false ->
        {:ok, env}

      nil ->
        {:error,
         {"Could not find mapping for status #{status}, mapping exist for statuses: #{
            inspect(Map.keys(mapping))
          }", env}}
    end
  end

  def evaluate_response({:error, _} = error, _), do: error
end
