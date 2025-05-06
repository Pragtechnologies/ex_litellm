defmodule ExLitellm do
  @moduledoc """
  Documentation for `ExLitellm`.
  """

  # @doc false
  # def get(url, params \\ nil) do
  #   url = parse_url(url, params)
  #
  #   init()
  #   |> auth()
  #   |> Req.get(url: url)
  # end
  #
  # def get(url, params, headers) do
  #   url = parse_url(url, params)
  #
  #   init()
  #   |> auth()
  #   |> parse_headers(headers)
  #   |> Req.get(url: url)
  # end

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
