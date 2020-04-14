defmodule Roll.SchemaMigration do
  @moduledoc """
  Defines a schema that works with a table that tracks schema migrations.
  The table name defaults to `roll_migrations`.
  """
  use Ecto.Schema

  import Ecto.Query, only: [from: 2]

  @primary_key false
  schema "roll_migrations" do
    field(:version, :integer)
    field(:executed, :boolean)

    timestamps()
  end

  @opts [timeout: :infinity, log: false]

  def ensure_schema_migrations_table!(repo, opts) do
    table_name = repo |> get_source |> String.to_atom()
    table = %Ecto.Migration.Table{name: table_name, prefix: opts[:prefix]}
    meta = Ecto.Adapter.lookup_meta(repo.get_dynamic_repo())

    commands = [
      {:add, :version, :bigint, primary_key: true},
      {:add, :executed, :boolean, default: false},
      {:add, :inserted_at, :naive_datetime, []},
      {:add, :updated_at, :naive_datetime, []}
    ]

    # DDL queries do not log, so we do not need to pass log: false here.
    repo.__adapter__.execute_ddl(meta, {:create_if_not_exists, table, commands}, @opts)
  end

  def versions(repo, prefix) do
    from(p in get_source(repo), select: type(p.version, :integer))
    |> Map.put(:prefix, prefix)
  end

  def up(repo, version, prefix) do
    %__MODULE__{version: version}
    |> Ecto.put_meta(prefix: prefix, source: get_source(repo))
    |> repo.insert(@opts)
  end

  def down(repo, version, prefix) do
    from(p in get_source(repo), where: p.version == type(^version, :integer))
    |> Map.put(:prefix, prefix)
    |> repo.delete_all(@opts)
  end

  def get_source(repo) do
    Keyword.get(repo.config, :migration_source, "roll_migrations")
  end
end
