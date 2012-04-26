from bottle import *
from bottle.ext.tornadosocket import TornadoWebSocketServer
import tornado.websocket

debug(True)

@get('/')
@view('echo')
def index():
    return { 'title': 'Echo' }


class EchoHandler(tornado.websocket.WebSocketHandler):
    def open(self):
        print 'Connected'

    def on_message(self, message):
        self.write_message(message)

    def on_close(self):
        print 'Connection closed'

if __name__ == "__main__":
    tornado_handlers = [
        (r"/websocket", EchoHandler)
    ]
    run(port=8080, reloader=True, server=TornadoWebSocketServer, handlers=tornado_handlers)
