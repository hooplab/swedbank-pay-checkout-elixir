defmodule SwedbankpayCheckout.Client.Psp.PaymentOrders do
  @moduledoc """
  payment order methods, require a `Tesla.Env.client()`, see `SwedbankpayCheckout.create_client/4`.
  """
  alias SwedbankpayCheckout.Client.Psp.PaymentOrders
  alias SwedbankpayCheckout.Client.Helpers
  alias SwedbankpayCheckout.Model.Operation

  @doc """
  Create a payment order, for displaying the payment menu view.
  """
  @spec create_payment_order(Tesla.Env.client(), PaymentOrders.PostRequest.t()) ::
          {:ok, PaymentOrders.OrderResponse.t()}
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
        decode_as: PaymentOrders.OrderResponse.shell()
      }
    })
  end

  @doc """
  Get a payment order, the payment_order_id should be the full id, with paths, not truncated to the UUID
  """
  @spec get_payment_order(Tesla.Env.client(), String.t()) ::
          {:ok, PaymentOrders.OrderResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def get_payment_order(client, payment_order_id) do
    Tesla.get(
      client,
      payment_order_id
    )
    |> Helpers.evaluate_response(%{
      200 => %{
        decode_as: PaymentOrders.OrderResponse.shell()
      }
    })
  end

  @doc """
  Get a payment order with expanded payer info, the payment_order_id should be the full id, with paths, not truncated to the UUID
  """
  @spec get_payment_order_with_payer(Tesla.Env.client(), String.t()) ::
          {:ok, PaymentOrders.OrderResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def get_payment_order_with_payer(client, payment_order_id) do
    Tesla.get(
      client,
      "#{payment_order_id}?$expand=payer"
    )
    |> Helpers.evaluate_response(%{
      200 => %{
        decode_as: PaymentOrders.OrderResponse.shell()
      }
    })
  end

  @typedoc false
  @typep payment_order_action :: :capture | :cancel | :reverse

  defp payment_order_action_to_rel(payment_order_action)
  defp payment_order_action_to_rel(:capture), do: "create-paymentorder-capture"
  defp payment_order_action_to_rel(:cancel), do: "create-paymentorder-cancel"
  defp payment_order_action_to_rel(:reverse), do: "create-paymentorder-reversal"

  @doc false
  @spec operation_from_action([Operation.t()], payment_order_action()) ::
          {:ok, Operation.t()} | {:error, String.t()}
  defp operation_from_action(operations, payment_order_action) do
    expected_rel = payment_order_action_to_rel(payment_order_action)

    case Enum.find(operations, fn %Operation{rel: actual_rel} -> actual_rel == expected_rel end) do
      nil -> {:error, "could not find action in operation"}
      op -> {:ok, op}
    end
  end

  @doc """
  Perform a cancellation, takes as input the response from `SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order/2`, and the actual request body.

  Swedbank does no recommend assuming any structure for these urls, as such we require the both the operations and payment_order fields of `PaymentOrders.PostResponse.t()`

  This function will return an error if the action is invalid,
    for example if :capture is called on a payment type that isn't two-step (Vipps or Swish)
    or if the action to operation translation in this function is out of date
  """
  @spec cancel_payment_order(
          Tesla.Env.client(),
          PaymentOrders.OrderResponse.t(),
          PaymentOrders.CancelRequest.t()
        ) ::
          {:ok, PaymentOrders.CancelResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def cancel_payment_order(
        client,
        %PaymentOrders.OrderResponse{operations: operations},
        %PaymentOrders.CancelRequest{} = request_body
      ) do
    with {:ok, %Operation{href: href}} <-
           operation_from_action(operations, :cancel) do
      Tesla.post(
        client,
        href,
        request_body
      )
      |> Helpers.evaluate_response(%{
        200 => %{
          decode_as: PaymentOrders.CancelResponse.shell()
        }
      })
    else
      {:error, err} -> {:error, err}
    end
  end

  @doc """
  Perform a capture, takes as input the response from `SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order/2`, and the actual request body.

  Swedbank does no recommend assuming any structure for these urls, as such we require the both the operations and payment_order fields of `PaymentOrders.PostResponse.t()`

  This function will return an error if the action is invalid,
    for example if :capture is called on a payment type that isn't two-step (Vipps or Swish)
    or if the action to operation translation in this function is out of date
  """
  @spec capture_payment_order(
          Tesla.Env.client(),
          PaymentOrders.OrderResponse.t(),
          PaymentOrders.CaptureRequest.t()
        ) ::
          {:ok, PaymentOrders.CaptureResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def capture_payment_order(
        client,
        %PaymentOrders.OrderResponse{operations: operations},
        %PaymentOrders.CaptureRequest{} = request_body
      ) do
    with {:ok, %Operation{href: href}} <-
           operation_from_action(operations, :capture) do
      Tesla.post(
        client,
        href,
        request_body
      )
      |> Helpers.evaluate_response(%{
        200 => %{
          decode_as: PaymentOrders.CaptureResponse.shell()
        }
      })
    else
      {:error, err} -> {:error, err}
    end
  end

  @doc """
  Perform a reversal, takes as input the response from `SwedbankpayCheckout.Client.Psp.PaymentOrders.get_payment_order/2`, and the actual request body.

  Swedbank does no recommend assuming any structure for these urls, as such we require the both the operations and payment_order fields of `PaymentOrders.PostResponse.t()`

  This function will return an error if the action is invalid,
    for example if :capture is called on a payment type that isn't two-step (Vipps or Swish)
    or if the action to operation translation in this function is out of date
  """
  @spec reverse_payment_order(
          Tesla.Env.client(),
          PaymentOrders.OrderResponse.t(),
          PaymentOrders.ReverseRequest.t()
        ) ::
          {:ok, PaymentOrders.ReverseResponse.t()}
          | {:error, Tesla.Env.t()}
          | {:error, {String.t(), Tesla.Env.t()}}
  def reverse_payment_order(
        client,
        %PaymentOrders.OrderResponse{operations: operations},
        %PaymentOrders.ReverseRequest{} = request_body
      ) do
    with {:ok, %Operation{href: href}} <-
           operation_from_action(operations, :reverse) do
      Tesla.post(
        client,
        href,
        request_body
      )
      |> Helpers.evaluate_response(%{
        200 => %{
          decode_as: PaymentOrders.ReverseResponse.shell()
        }
      })
    else
      {:error, err} -> {:error, err}
    end
  end
end
