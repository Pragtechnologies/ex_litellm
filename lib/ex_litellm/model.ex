defmodule ExLitellm.Model do
  @moduledoc """
  Handles model functions
  """

  def chat(params) do
    "/chat/completions"
    |> ExLitellm.post(params)
  end
end
