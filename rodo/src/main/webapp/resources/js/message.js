         var wsUri = "ws://203.233.196.105:8899/rodo/echo.do";
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
         }
         
         function onMessage(evt) {
        	console.log(evt.data);
        	var message = "<img style='width:20px;' src='resources/img/message.png'> ";
			var inner = $(".messagestatus").html();
			if(!inner.includes("message")){
				$(".messagestatus").html(message+inner);
			}
         }
         
         function onError(evt) {
        	 console.log('ERROR: ' + evt.data);
         }
         
         function doSend() {
         	var message = document.getElementById("loginId").value;
            websocket.send("login*Session:"+message);
         }
         
         
         window.addEventListener("load", init, false);
         
         function messageWindow(){
        	 
        	 window.open("messageList", "", "width=540, height=350, left=400, top=100");
        	 
         }