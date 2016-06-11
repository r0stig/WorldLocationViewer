defmodule Chat do
	use Application

	def start(_type, _args) do 
		import Supervisor.Spec, warn: false

		children = [
			worker(Registry, [], [name: :client_registry]),
				Plug.Adapters.Cowboy.child_spec(:http, MyPlug, [], [
				port: 8080,
				dispatch: dispatch
			])
		]

		opts = [strategy: :one_for_one, name: Chat.Supervisor]
		Supervisor.start_link(children, opts)
	end

  	defp dispatch do 
	[
		{ :_, [
			{"/websocket", WebsocketHandler, []},
			{:_, Plug.Adapters.Cowboy.Handler, { MyPlug, [] }}
		]
	}]
	end
end
