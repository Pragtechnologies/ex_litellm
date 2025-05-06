defmodule ExLitellm do
  @moduledoc """
  Documentation for `ExLitellm`.
  """

  @doc false
  def get(url, params \\ nil) do
    url = parse_url(url, params)

    init()
    |> auth()
    |> Req.get(url: url)
  end

  def get(url, params, headers) do
    url = parse_url(url, params)

    init()
    |> auth()
    |> parse_headers(headers)
    |> Req.get(url: url)
  end

  def post(url, body \\ %{}) do
    init()
    |> auth()
    |> Req.post(
      url: url,
      json: body,
      connect_options: [timeout: 240_000],
      receive_timeout: 240_000
    )
  end

  def post(url, body, headers) do
    init()
    |> auth()
    |> parse_headers(headers)
    |> Req.post(url: url, json: body)
  end

  defp parse_headers(request, headers) do
    request
    |> api_key(headers)
  end

  defp api_key(req, %{api_key: api_key}) do
    req
    |> Req.Request.put_headers([
      {"Ocp-Apim-Subscription-Key", api_key}
    ])
  end

  defp parse_url(url, nil), do: url
  defp parse_url(url, params), do: url <> "?" <> URI.encode_query(params)

  defp init do
    base_url = Application.get_env(:ex_litellm, :base_url)

    Req.new(base_url: base_url)
  end

  defp auth(req) do
    key = Application.get_env(:ex_litellm, :api_key)

    req
    |> Req.Request.put_headers([
      {"Content-Type", "application/json"},
      {"Ocp-Apim-Subscription-Key", "#{key}"}
    ])
  end
end
