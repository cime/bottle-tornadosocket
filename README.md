Bottle Tornado Websocket
========================

This project adds websocket capabilities to [bottle](http://bottlepy.org), leveraging [tornado](http://www.tornadoweb.org/)

### Install
Use `pip` or `easy_install`:

    pip install bottle-tornado-websocket

### Requirements

* Bottle
* Tornado

### Usage
Import the server and tornado's WebSocketHandler:

    from bottle_tornado_websocket import TornadoWebSocketServer
    from tornado.websocket import WebSocketHandler

Create your application handlers, for example:

    class EchoWebSocket(tornado.websocket.WebSocketHandler):
        def open(self):
            print 'Connected')

        def on_message(self, message):
            self.write(message)

        def on_close(self):
           print 'Connection closed')

Map handlers to urls:

    tornado_handlers = [
            (r"/echo", EchoWebSocket)
        ]

Note: the `.*` is automatically mapped as a last handler to your normal bottle application

And then use the provided server:

    run(port=8080, server=TornadoWebSocketServer, handlers=tornado_handlers)

### Example
To echo chat example just run `chat.py` in `examples/echo` folder:

    python echo.py

To run chat example just run `chat.py` in `examples/chat` folder:

    python chat.py
