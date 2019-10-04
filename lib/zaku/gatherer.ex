defmodule Zaku.Gatherer do
  use GenServer

  @me Gatherer

  # API

  def start_link(worker_count) do
    GenServer.start_link(__MODULE__, worker_count, name: @me)
  end

  def done(), do: GenServer.cast(@me, :done)

  def result(path, metadata) do
    GenServer.cast(@me, {:result, path, metadata})
  end

  # GenServer callbacks

  def init(worker_count) do
    Process.send_after(self(), :kickoff, 0)
    {:ok, worker_count}
  end

  def handle_cast(:done, _worker_count = 1) do
    report_results()
    System.halt(0)
  end

  def handle_cast(:done, worker_count) do
    {:noreply, worker_count - 1}
  end

  def handle_cast({:result, path, metadata}, worker_count) do
    Zaku.Results.add_metadata_for(path, metadata)
    {:noreply, worker_count}
  end

  def handle_info(:kickoff, worker_count) do
    1..worker_count
    |> Enum.each(fn _ -> Zaku.WorkerSupervisor.add_worker() end)

    {:noreply, worker_count}
  end

  # Private functions

  defp report_results do
    IO.inspect(Zaku.Results.get_final_results())
  end
end
