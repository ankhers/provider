defmodule Provider.Cache do
  def new(name) do
    :ets.new(name, [:named_table, {:read_concurrency, true}, :public])
  end

  def set(table, objects), do: :ets.insert(table, objects)

  def get(table, key) do
    case :ets.lookup(table, key) do
      [{^key, value}] -> {:ok, value}
      [] -> {:error, :not_found}
    end
  end
end
