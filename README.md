#Websocket broadcaster in Elixir
Once a client connects and accepts giving out it's geocoordinates the websocket server will broadcast 
the coordinates to all connected clients to show the different users position on google maps.

# Run it!
Once you've got Elixir installed run with:
> iex -S mix 
Or
> mix run --no-halt

Create your google maps API key and put it in priv/index.html after ?key= in the include-script for google maps

Go to your favourite browser to the adress:
> localhost:8080/static/index.html