defmodule ExLitellm.Model do
  def chat(params) do
    "/chat/completions"
    |> ExLitellm.post(params)
  end
end
