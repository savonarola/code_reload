defmodule CodeReload do
  @moduledoc false

  def reload(pid, module) do
    :sys.suspend(pid)
    :code.purge(module)
    :code.load_file(module)
    :sys.change_code(pid, module, '0.1.0', nil)
    :sys.resume(pid)
  end

  def start_server_under_supervisor do
    Supervisor.start_child(CodeReload.Supervisor, CodeReload.Server.child_spec([]))
  end

end
