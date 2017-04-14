         var wsUri = "ws://203.233.196.103:8888/rodo/echo.do";
         var websocket;
         
         function init() {
            
             websocket = new WebSocket(wsUri);
             websocket.onopen = function(evt) {
                 onOpen(evt)
             };
	         setTimeout(function(){
	        	 doSend();
	         }, 500)
			 receiveMessage();
             
         }
        
         function receiveMessage(){
             websocket.onmessage = function(evt) {
                 onMessage(evt)
             };
             websocket.onerror = function(evt) {
                 onError(evt)
             };
         }
         
        
         function onOpen(evt) {
             //writeToScreen("Connected to Endpoint!");
         }
         
         function onMessage(evt) {
        	console.log(evt.data);
			var inner = $(".loginstatus").html();
			$(".loginstatus").html("<img style='width:20px;' src='resources/img/message.png'> "+inner);
         }
         
         function onError(evt) {
        	 console.log('ERROR: ' + evt.data);
         }
         
         function doSend() {
         	var message = document.getElementById("loginId").value;
            websocket.send("login*Session:"+message);
            //websocket.close();
         }
         
         
         window.addEventListener("load", init, false);
         
         function messageWindow(){
        	 
        	 window.open("messageList", "", "width=520, height=350, left=400, top=100");
        	 
         }