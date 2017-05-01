package project2.scmaster.rodo.dao;


import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Message;

public interface MessageMapper 
{
public void writeMessage(Message message);
	
	public void writereceiveMessage(Message message);
	
	public ArrayList<Message> receivedMessage(RowBounds rb, String id);
	// 기존의 메세지 리스트
	
	public Message sendreadMessage(int messagenum);
	
	public Message receivedreadMessage(int messagenum);
	
	public ArrayList<Message> newMessage(String id);

	public ArrayList<Message> sentMessage(String id);
	
	public int receivelistsize(String id);
	
	public int findreceivelistsize(String id, String searchText);
	
	public int sendlistsize(String id);
	
	public int findsendlistsize(String id, String searchText);
	
	// 받은 메세지, 보낸 메세지 리스트를 구분하고 페이징을 위해
	// 받을 리스트를 새로이 만들기로 함.
	
	public ArrayList<Message> receivelist(RowBounds rb, String id);
	
	public ArrayList<Message> sendlist(RowBounds rb, String id);
	
	public int deletereceiveMessage(Message message);
	
	public int deletesendMessage(Message Message);
	
	public int alldeleteReceive(String receiver);
	
	public int alldeleteSend(String sender);
	
	public List<Message> findreceivedMessage(RowBounds rb, String searchText);

	public List<Message> findsentMessage(RowBounds rb, String searchText);
	
	public void readCheck(int msgnum);
	
}