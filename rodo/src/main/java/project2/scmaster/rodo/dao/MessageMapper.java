package project2.scmaster.rodo.dao;


import java.util.ArrayList;

import project2.scmaster.rodo.vo.Message;

public interface MessageMapper 
{

	public void writeMessage(Message message);
	
	public ArrayList<Message> receivedMessage(String id);
	
	public Message readMessage(int messagenum);
	
	public ArrayList<Message> newMessage(String id);
	
	public ArrayList<Message> sentMessage(String id);
	
}