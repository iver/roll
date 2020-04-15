defmodule Support.Repo do
  def start_link(_) do
    Process.put(:started, true)

    Task.start_link(fn ->
      Process.flag(:trap_exit, true)

      receive do
        {:EXIT, _, :normal} -> :ok
      end
    end)
  end

  def stop do
    :ok
  end

  def __adapter__ do
    EctoSQL.TestAdapter
  end

  def config do
    [priv: "tmp/#{inspect(Roll.Migrate)}", otp_app: :roll]
  end

  def put_dynamic_repo(dynamic) when is_atom(dynamic) or is_pid(dynamic) do
    Process.put({__MODULE__, :dynamic_repo}, dynamic) || __MODULE__
  end
end
