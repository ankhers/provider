defmodule Provider.Cache do
  @moduledoc """
  This module will act as a cache to store the values in. This will prevent us
  from needing to query the source on every call which could be expensive.
  """

  @spec new(atom()) :: :ok
  def(new(name)) do
    :ets.new(name, [:named_table, {:read_concurrency, true}, :public])

    :ok
  end

  @spec set(atom(), Keyword.list()) :: :ok
  def set(table, objects) do
    :ets.insert(table, objects)

    :ok
  end

  @spec get(atom(), atom()) :: term()
  def get(table, key) do
    [{^key, value}] = :ets.lookup(table, key)

    value
  end
end
