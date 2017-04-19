package project2.scmaster.rodo.util;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.HashSet;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SocketHandler extends TextWebSocketHandler {

	private final Logger logger = LogManager.getLogger(getClass());
	private HashSet<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	private HashMap<String, String> sessionMap = new HashMap<String, String>();

	public SocketHandler() {
		super();
		this.logger.info("create SocketHandler instance!");
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);

		sessionSet.remove(session);
		this.logger.info("remove session!");
		sessionMap.remove(session.getId());
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);

		sessionSet.add(session);
		this.logger.info("add session!");
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);

		this.logger.info("receive message:" + message.toString());
		String msg = (String) message.getPayload();

		if (msg.contains("login*Session")) {
			String id = msg.substring(msg.indexOf(":") + 1);
			sessionMap.put(session.getId(), id);
		} else {
			sendMessage(msg);
		}

	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		this.logger.error("web socket error!", exception);
		sessionMap.remove(session.getId());
	}

	@Override
	public boolean supportsPartialMessages() {
		this.logger.info("call method!");

		return super.supportsPartialMessages();
	}

	public void sendMessage(String message) {
		for (WebSocketSession session : this.sessionSet) {
			System.out.println(message);
			if (session.isOpen() && message.equals(sessionMap.get(session.getId()))) {
				try {
					session.sendMessage(new TextMessage(message));
				} catch (Exception ignored) {
					this.logger.error("fail to send message!", ignored);
				}
			}
		}
	}

}