defmodule Zaku.Worker do
	use GenServer, restart: :transient

	def start_link(_) do
		GenServer.start_link(__MODULE__, :no_args)
	end

	def init(:no_args) do
		Process.send_after(self(), :do_one_file, 0)
		{:ok, nil}
	end

	def handle_info(:do_one_file, _) do
		Zaku.PathFinder.next_path()
		|> add_result()
	end


	# Private function

	defp add_result(nil) do
		Zaku.Gatherer.done()
		{:stop, :normal, nil}
	end

	defp add_result(path) do
		Zaku.Gatherer.result(path, metadata_of_file_at(path))
	end

	defp metadata_of_file_at(path) do
		System.cmd("exiftool", [path]) 
		|> elem(0)
		|> String.split("\n")
		|> Enum.reduce(%{}, fn (txt_row, metadata) ->
				[field | [ value | []]] = 
					txt_row |> String.split(":")
					Map.put(metadata, field, value)
		 end)
	end

end