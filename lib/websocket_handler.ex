defmodule TestMessage do
  @derive [Poison.Encoder]
  defstruct [:message]
end

defmodule WebsocketHandler do
  @behaviour :cowboy_websocket_handler

  def init({tcp, http}, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def websocket_init(_TransportName, req, _opts) do
    Registry.register_client(self())
    {:ok, req, :undefined_state }
  end

  # Required callback.  Put any essential clean-up here.
  def websocket_terminate(_reason, _req, _state) do
    Registry.remove_client(self())
    :ok
  end

  def websocket_handle({:text, content}, req, state) do
    Enum.each(Registry.get_all(), fn pid -> send(pid, {:send, content}) end)
    {:ok, req, state}
  end
  
  def websocket_handle(_data, req, state) do    
    {:ok, req, state}
  end

  def websocket_info({:send, message}, req, state) do
    { :reply, {:text, message}, req, state}
  end

  # fallback message handler 
  def websocket_info(_info, req, state) do
    IO.puts "websocket info fallback thingy"
    IO.puts _info
    {:ok, req, state}
  end
end
