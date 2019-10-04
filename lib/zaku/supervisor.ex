defmodule Zaku.Supervisor do
	use Supervisor

	def start_link({path_to_folder, n_workers}) do 
	  # result = {:ok, sup} = Supervisor.start_link(__MODULE__, [path_to_folder, n_workers])
	  # start_workers(sup, repo)
	  # result

	  Supervisor.start_link(__MODULE__, {path_to_folder, n_workers})
	end

	#def start_workers(sup, repo) do 
	#  {:ok, store} = Supervisor.start_child(sup, worker(ElixirLinter.Store, [repo]))
	#  Supervisor.start_child(sup, supervisor(ElixirLinter.SubSupervisor, [store]))
	#end

	def init({path_to_folder, n_workers}) do
	  children = [
	      Zaku.Results,
	      {Zaku.PathFinder, path_to_folder},
	      Zaku.WorkerSupervisor,
	      {Zaku.Gatherer, n_workers}
      ]
      opts = [strategy: :one_for_all, name: Zaku.Supervisor]
	  Supervisor.init(children, opts)
	end

end