from bottle import *
from bottle.ext.tornadosocket import TornadoWebSocketServer
import tornado.web
import tornado.websocket

debug(True)

@get('/')
@view('chat')
def index():
    return { 'title': 'Bottle WebSocket Chat' }

class MessageDispatcher(object):
    clients = []

    @classmethod
    def add_client(cls, client):
        cls.clients.append(client)

    @classmethod
    def remove_client(cls, client):
        cls.clients.remove(client)

    @classmethod
    def broadcast(cls, message):
        for c in cls.clients:
            c.write_message(message)

class ChatHandler(tornado.websocket.WebSocketHandler):
    clients = []
    unique_id = 0

    @classmethod
    def get_username(cls):
        cls.unique_id += 1
        return 'User%d' % cls.unique_id
	
    def open(self):
        self.username = self.get_username()
        MessageDispatcher.add_client(self)

    def on_message(self, message):
        if message == '/quit':
            MessageDispatcher.remove_client(self)
            self.close()
        MessageDispatcher.broadcast('%s: %s' % (self.username, message))

    def on_close(self):
        MessageDispatcher.remove_client(self)

if __name__ == "__main__":
    tornado_handlers = [
        (r"/ws", ChatHandler),
        (r"/(favicon.ico)", tornado.web.StaticFileHandler, {"path": "./static/"}),
        (r"/css/(.*)", tornado.web.StaticFileHandler, {"path": "./static/css/"}),
        (r"/js/(.*)", tornado.web.StaticFileHandler, {"path": "./static/js/"}),
        (r"/img/(.*)", tornado.web.StaticFileHandler, {"path": "./static/img/"}),
    ]
    run(port=8080, reloader=True, server=TornadoWebSocketServer, handlers=tornado_handlers)
