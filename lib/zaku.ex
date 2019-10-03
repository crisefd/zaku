defmodule Zaku do
  @moduledoc """
  Documentation for Zaku.
  """
  use Application

  def start(_type, _args) do
    children = [
      Zaku.Results,
      {Zaku.PathFinder, "."},
      Zaku.WorkerSupervisor,
      {Zaku.Gatherer, 1}
    ]
    opts = [:strategy: :one_for_all, name: Zaku.Supervisor]
    Supervisor.start_link(children, opts)
  end
 
end
