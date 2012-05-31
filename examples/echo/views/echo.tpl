<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>{{title}}</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

    <script type="text/javascript">
        $(function(){
            if (!window.WebSocket) {
                if (window.MozWebSocket) {
                    window.WebSocket = window.MozWebSocket;
                } else {
                    alert('Your browser doesn\'t support WebSockets.');
                }
            }

            var ws = new WebSocket("ws://localhost:8080/websocket");
            ws.onopen = function() {
                ws.send("Hello, world");
            };
            ws.onmessage = function (evt) {
                alert(evt.data);
            };
        });
    </script>
</head>
<body>
    <h1>{{title}}</h1>
</body>
</html>