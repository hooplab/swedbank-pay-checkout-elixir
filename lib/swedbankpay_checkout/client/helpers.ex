defmodule SwedbankpayCheckout.Client.Helpers do
  @moduledoc false

  def evaluate_response({:ok, %Tesla.Env{status: status, body: body} = env}, mapping) do
    case mapping[status] do
      %{decode_as: decode_as} ->
        {:ok, Poison.Decode.decode(body, as: decode_as)}

      false ->
        {:ok, env}

      nil ->
        {:error, env}
    end
  end

  def evaluate_response({:error, _} = error, _), do: error
end
