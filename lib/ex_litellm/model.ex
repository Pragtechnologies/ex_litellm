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

  # 1-second 8-bit PCM silent WAV file
  # 1-second silent WAV (8-bit PCM)
  @base64_wav "UklGRiQAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQAAAAA="

  def write_sample_wav(path \\ "test/fixtures/sample.wav") do
    dir = Path.dirname(path)
    File.mkdir_p!(dir)

    wav_binary = Base.decode64!(@base64_wav)
    File.write!(path, wav_binary)

    path
  end
end
