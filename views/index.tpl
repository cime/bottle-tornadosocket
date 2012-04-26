<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>{{title}}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	
	<script src="/js/jquery-1.7.2.min.js"></script>

    <link rel="shortcut icon" href="/favicon.ico">
	
	<style>
		textarea {
			width: 100%;
			height: 250px;
		}
		
		input#message {
			width: 50%;
		}
	</style>
	
	<script>
		$(function(){
			var ws = new WebSocket('ws://localhost:9090/ws');
			ws.onmessage = function(evt) {
				$('#chat').val($('#chat').val() + '\n' + evt.data);
			};
			ws.onclose = function(evt) {
				$('#message').attr('disabled', 'disabled');
				$('#send').attr('disabled', 'disabled');
			};
		
			$('#send').click(function(){
				ws.send($('#message').val());
				$('#message').val('');
			});
		});
	</script>
  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">{{title}}</a>
          <div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="/">Home</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">
		<textarea id="chat" readonly>Chat:</textarea>
		<br />
		<input type="text" id="message" /> <input type="submit" id="send" value="Send" />
    </div> <!-- /container -->

  </body>
</html>
