defmodule ExLitellm.Model do
  @moduledoc """
  Handles model functions
  """

  def chat(params) do
    "/chat/completions"
    |> ExLitellm.post(params)
  end

  def audio_transcribe(%Multipart{} = multipart) do
    ExLitellm.post(
      "/audio/transcriptions",
      %{},
      multipart: true,
      headers: [
        {"content-type", Multipart.content_type(multipart, "multipart/form-data")}
      ],
      body: Multipart.body_stream(multipart)
    )
  end

  def audio_transcribe(_), do: {:error, "You must pass a valid Multipart struct"}
end
