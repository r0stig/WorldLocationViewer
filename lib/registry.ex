defmodule Registry do

	def start_link do
		Agent.start_link(fn -> MapSet.new end, name: __MODULE__)
	end

	def register_client(pid) do
		Agent.update(__MODULE__, &MapSet.put(&1, pid))
	end

	def remove_client(pid) do
		Agent.update(__MODULE__, &MapSet.delete(&1, pid))
	end

	def get_all do
		Agent.get(__MODULE__, fn set -> set end)
	end
end