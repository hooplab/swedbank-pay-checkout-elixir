defmodule SwedbankpayCheckout.Middleware.JsonUtil do
  @moduledoc false

  # if struct
  @spec mapKeys(any(), (String.t() -> String.t())) :: any()
  defp mapKeys(struct, keyFunction) when is_struct(struct) do
    mapKeys(Map.from_struct(struct), keyFunction)
  end

  # if map
  defp mapKeys(map, keyFunction) when is_map(map) do
    for {key, value} <- map,
        into: %{},
        do: {
          keyFunction.(key),
          mapKeys(value, keyFunction)
        }
  end

  # if list
  defp mapKeys(list, keyFunction) when is_list(list) do
    Enum.map(list, fn e -> mapKeys(e, keyFunction) end)
  end

  # else, values
  defp mapKeys(value, _) do
    value
  end

  def encode_and_camelize(%{} = body) do
    camelized = mapKeys(body, fn key -> Inflex.camelize(key, :lower) end)
    Poison.encode(camelized)
  end

  def decode_and_snake_case(body) do
    case Poison.decode(body) do
      {:ok, parsed} ->
        {:ok, mapKeys(parsed, &Inflex.underscore/1)}

      {:error, err} ->
        {:error, {err, body}}
    end
  end
end
