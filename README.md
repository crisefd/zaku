# Zaku

**An OTP application to extract media files's metadata**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `zaku` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zaku, "~> 0.1.0"}
  ]
end
```

## Usage
By calling `Zaku.Runner.run` You need to pass the absolute path to the folder and the number of processes to use
```elixir
Zaku.Runner.run {"/Users/cristhianfuertes/Desktop/dummy", 1}
```

Also, you need to have `exiftool` installed in a Unix environment

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/zaku](https://hexdocs.pm/zaku).



## TODO: Making it work with escript