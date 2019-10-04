defmodule Zaku.CLI do
  require Logger

  def main(args) do
    args
    |> parse_args()
    |> process()
  end

  def process(:help) do
    IO.puts("""
      usage: zaku --processes n_processes path_to_folder
    """)
    System.halt(0)
  end

  def process({path_to_folder, n_processes}) do
    Zaku.start(nil, {path_to_folder, n_processes})
  end

  def parse_args(argv) do
    {parsed, args, _} =
      OptionParser.parse(argv,
        switches: [help: :boolean, processes: :integer],
        aliases: [h: :help, p: :processes]
      )
   Logger.info "parsed: #{inspect parsed}"
    Logger.info "args: #{inspect args}"
    args_to_internal_representation(parsed, args)
  end

  defp args_to_internal_representation([help: true], _) do
    :help
  end

  defp args_to_internal_representation(_, nil), do: :help

  defp args_to_internal_representation(option, folder) do
    case option do
      [processes: p] -> {folder, p}
      _ -> :help
    end
    
  end

end