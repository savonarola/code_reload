defmodule CodeReload.Server do
  @moduledoc false

  use GenServer

  require Logger

  alias __MODULE__, as: Server

  def start_link(_ \\ []) do
    GenServer.start_link(Server, [])
  end

  def init([]) do
    Process.flag(:trap_exit, true)
    spawn_link(&logger_a/0)
    spawn_link(&logger_b/0)
    {:ok, %{}}
  end

  def code_change(_old_vsn, st, _extra) do
    Logger.info("#{__MODULE__} code change")
    {:ok, st}
  end

  def handle_info(message, st) do
    Logger.info("Received message #{inspect message}")
    {:noreply, st}
  end

  defp logger_a do
    Logger.info("logger #{inspect self()} aa!")
    :timer.sleep(5000)
    logger_a()
  end

  def logger_b do
    Logger.info("logger #{inspect self()} bb!")
    :timer.sleep(5000)
    Server.logger_b()
  end
end
