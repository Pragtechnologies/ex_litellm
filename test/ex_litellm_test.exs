defmodule ExLitellmTest do
  alias ExLitellm.Model

  alias Multipart.Part

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes/model")
    :ok
  end

  describe "chat/1" do
    test "will return a result" do
      use_cassette "valid_create_customer_for_syd" do
        messages = [
          %{
            role: "user",
            content:
              "Convert to FHIR Resource `Juan dela Cruz is a 73-year-old male presenting for a 3:30pm routine follow up with his primary care physician, Dr. Emily Flores, at the Mabuhay Medical Center. He is attending to hear about the results of a regular blood test, which indicated a mild iron deficiency. Juan has hyperlipidemia and takes Lipitor 20mg twice daily, as well as aspirin for his angina. He had a hip replacement in 2019, and COVID in September of 2021. Since then he has had 3 COVID vaccinations, the first two with Pfizer and the third with Moderna. Dr. Flores sends him for a PSA test, and gives him a script for doxycycline.`"
          }
        ]

        response_format = %{
          type: "json_object",
          schema: %{
            type: "object",
            properties: %{
              resourceType: %{
                type: "string",
                enum: ["Bundle"]
              },
              type: %{
                type: "string",
                enum: ["transaction", "collection", "document"]
              },
              entry: %{
                type: "array",
                items: %{
                  type: "object",
                  properties: %{
                    fullUrl: %{
                      type: "string"
                    },
                    resource: %{
                      type: "object"
                    }
                  },
                  required: ["fullUrl", "resource"]
                }
              }
            },
            required: ["resourceType", "type", "entry"]
          }
        }

        params = %{
          model: "claude-3-5-haiku-latest",
          messages: messages,
          temperature: 0.0,
          max_tokens: 4000,
          system:
            "You are a healthcare interoperability expert that specializes in converting clinical narratives to FHIR resources. Ensure all FHIR resources follow the latest FHIR R4 specifications. Include appropriate codings from standard terminologies (SNOMED CT, LOINC, RxNorm) where applicable. Create a complete Bundle resource that includes all relevant resources with proper references between them. Follow these guidelines: 1) Use consistent resource IDs with meaningful names, 2) Include proper resource references, 3) Use proper FHIR datatypes, 4) Include appropriate status fields for all resources, 5) Provide complete code systems and display values, 6) Include only information explicitly stated in the text.",
          response_format: response_format
        }

        assert {:ok, result} = Model.chat(params)
        [choice | _] = result.body["choices"]

        {:ok, content} =
          choice["message"]["content"]
          |> Jason.decode()

        assert content["resourceType"] == "Bundle"
      end
    end
  end

  # describe "audio_transcribe/1" do
  #   test "returns a successful transcription" do
  #     use_cassette "valid_audio_transcription" do
  #       # Prepare a small audio test file
  #       file_path = "test/fixtures/audio.wav"

  #       model = "whisper-1"
  #       temperature = 0.0
  #       filename = Path.basename(file_path)

  #       multipart =
  #         Multipart.new()
  #         |> Multipart.add_part(%Part{
  #           body: File.read!(file_path),
  #           headers: [
  #             {"Content-Disposition", ~s(form-data; name="file"; filename="#{filename}")},
  #             {"Content-Type", "audio/wav"}
  #           ]
  #         })
  #         |> Multipart.add_part(%Part{
  #           body: model,
  #           headers: [{"Content-Disposition", ~s(form-data; name="model")}]
  #         })

  #       assert {:ok, result} = Model.audio_transcribe(multipart)
  #       # Depending on Whisper output structure
  #       assert is_map(result.body)
  #       assert is_binary(result.body["text"])
  #       refute result.body["text"] == ""
  #     end
  #   end

  #   test "returns error for non-multipart input" do
  #     assert {:error, message} = Model.audio_transcribe("not a multipart")
  #     assert message == "You must pass a valid Multipart struct"
  #   end
  # end
end
