defmodule SwedbankpayCheckout.Client.Helpers do
  @moduledoc false

  def evaluate_response({:ok, %Tesla.Env{status: status, body: body} = env}, mapping) do
    case mapping[status] do
      %{decode_as: decode_as} ->
        {:ok, Poison.Decode.decode(body, as: decode_as)}

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
