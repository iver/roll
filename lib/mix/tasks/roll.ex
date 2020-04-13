defmodule Mix.Tasks.Roll do
  use Mix.Task

  @shortdoc "Prints Roll help information"

  @moduledoc """
  Prints Roll tasks and their information.
  mix roll
  """

  @doc false
  def run(args) do
    {_opts, args} = OptionParser.parse!(args, strict: [])

    case args do
      [] -> general()
      _ -> Mix.raise("Invalid arguments, expected: mix roll")
    end
  end

  defp general() do
    Application.ensure_all_started(:ecto)
    Mix.shell().info("Roll v#{Application.spec(:ecto, :vsn)}")
    Mix.shell().info("A Ecto complement for migration forward for Elixir.")
    Mix.shell().info("\nAvailable tasks:\n")
    Mix.Tasks.Help.run(["--search", "roll."])
  end
end
