defmodule Zaku.Results do
	use GenServer

	@me __MODULE__

	# API

	def start_link(_) do
		GenServer.start_link(__MODULE__, :no_args, name: @me)
	end

	def add_metadata_for(path, metadata) do
		GenServer.cast(__MODULE__, {:add, path, metadata})
	end

	def get_final_results() do
		GenServer.call(@me, :final_results)
	end

	# GenServer callbacks

	def init(:no_args), do: {:ok, %{}}

	def handle_cast({:add, path, metadata}, results) do
		results = 
			Map.update( results,
						path,
						[metadata],
						fn existing -> 
							[metadata | existing]
						end)
		{:noreply, results}
	end

	def handle_call(:final_results, _from , results) do
		{:reply, results, results}
	end

end