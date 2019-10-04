defmodule Zaku do
  @moduledoc """
  Documentation for Zaku.
  """
  use Application

  def start(_type, {path_to_folder, n_workers}) do
    children = [
      Zaku.Results,
      {Zaku.PathFinder, path_to_folder},
      Zaku.WorkerSupervisor,
      {Zaku.Gatherer, n_workers}
    ]
    opts = [strategy: :one_for_all, name: Zaku.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
