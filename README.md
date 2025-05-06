# ExLiteLLM
[![License](https://img.shields.io/hexpm/l/ex_litellm.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![Version](https://img.shields.io/hexpm/v/ex_litellm.svg)](https://hex.pm/packages/ex_litellm)
[![CI](https://github.com/pragtechnologies/ex_litellm/actions/workflows/elixir.yml/badge.svg)](https://github.com/pragtechnologies/ex_litellm/actions/workflows/elixir.yml)

ExLiteLLM is an elixir sdk for [LiteLLM Docs](https://docs.litellm.ai/). 


## Installation
Put this in your `mix.exs` and run `mix deps.get`.

```elixir
def deps do
  [
    {:ex_litellm, "~> 0.1"}
  ]
end
```

## Usage

Before you use, you need to have an api_key from your proxy server LiteLLM. 

Once done, add your credentials inside your configs. 

```
config :ex_litellm,
  base_url: "REPLACE WITH PROXY SERVER",
  api_key: "REPLACE WITH YOUR API KEY"
```

## Developers

To contribute to this project:

- Fork this project and clone in your machine
- Copy `config.secret.backup.exs` to `config.secret.exs` then set your credentials
- Look for new updates at [LiteLLM API Docs](https://docs.litellm.ai/docs/)
- Follow code pattern 

Before you submit pull request:

- Run `mix coveralls`. Be sure coverage is at 100%
- Run `mix credo`. Be sure everything is clean.
- Run `mix dialyzer`. Be sure everything is good.


## License 
Copyright (c) 2025 Noel Del Castillo

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at 

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
