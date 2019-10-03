defmodule Zaku.Results do
	use GenServer

	# API

	def start_link(_) do
		GenServer.start_link(__MODULE__, :no_args, name: __MODULE__)
	end

	def add_metadata_for(path, metadata) do
		GenServer.cast(__MODULE__, {:add, path, metadata})
	end

	# GenServer callbacks

	def init(:no_args), do: {:ok, %{}}

	def handle_cast({:add, path, metadata}, results) do
		results = 
			Map.update( results,
						metadata,
						[path],
						fn existing -> 
							[path | existing]
						end)
		{:noreply, results}
	end

	

end