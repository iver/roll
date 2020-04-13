defmodule Mix.RollSQLTest do
  use ExUnit.Case, async: true
  import Mix.RollSQL

  defmodule Repo do
    def config do
      [priv: Process.get(:priv), otp_app: :roll]
    end
  end

  test "source_priv_repo" do
    Process.put(:priv, nil)
    assert source_repo_priv(Repo) == Path.expand("priv/repo", File.cwd!())
    Process.put(:priv, "hello")
    assert source_repo_priv(Repo) == Path.expand("hello", File.cwd!())
  end
end
