defmodule Zaku.WorkerSupervisor do
  use DynamicSupervisor

  @me WorkerSupervisor

  # API

  def start_link(_) do
    DynamicSupervisor.start_link(
      __MODULE__,
      :no_args,
      name: @me
    )
  end

  def add_worker do
    {:ok, _pid} =
      DynamicSupervisor.start_child(@me, Zaku.Worker)
  end

  # GenServer callbacks

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
