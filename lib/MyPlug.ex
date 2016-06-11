defmodule MyPlug do
  use Plug.Router
  use Plug.Builder
  
  import Plug.Conn

  # if env..
  use Plug.Debugger, otp_app: :chat

  plug Plug.Logger, log: :debug

  plug Plug.Static, at: "/static", from: "priv/"
  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "Hello, world!")
  end

  get "/" do
    send_resp(conn, 200, "<html><head><head><body><script")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end