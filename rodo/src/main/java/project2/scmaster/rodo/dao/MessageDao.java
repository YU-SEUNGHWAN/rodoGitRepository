package project2.scmaster.rodo.dao;


import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Message;

@Repository
public class MessageDao
{	
	@Autowired
	private SqlSession session;
	
	public void writeMessage(Message message) 
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		mapper.writeMessage(message);
	}
	
	public void writereceiveMessage(Message message)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		mapper.writereceiveMessage(message);
	}
	
	public ArrayList<Message> receivedMessage(int startRecode, int CountPerPage, String id)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, CountPerPage);
		
		ArrayList<Message> list = mapper.receivelist(rb, id);
		
		return list;
	}
	
	public ArrayList<Message> sentMessage(String id)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		ArrayList<Message> list = mapper.sentMessage(id);
		
		return list;
	}

	public Message sendreadMessage(int messagenum) 
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		Message message = mapper.sendreadMessage(messagenum);
		
		return message;
	}

	public Message receivedreadMessage(int messagenum)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		Message message = mapper.receivedreadMessage(messagenum);
		
		return message;
	}
	
	public int receivelistsize(String id) 
	{
		// TODO Auto-generated method stub
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.receivelistsize(id);
		
		return result;
	}
	
	public int findreceivelistsize(String id, String searchText)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.findreceivelistsize(id, searchText);
		
		return result;
	}

	public int sendlistsize(String id)
	{
		// TODO Auto-generated method stub
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.sendlistsize(id);
		
		return result;
	}
	
	public int findsendlistsize(String id, String searchText)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.findsendlistsize(id, searchText);
		
		return result;
	}
	
	public ArrayList<Message> receivelist(int startRecode, int CountPerPage, String id)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, CountPerPage);
		
		ArrayList<Message> list = mapper.receivelist(rb, id);
		
		return list;
	}
	
	public ArrayList<Message> sendlist(int startRecode, int CountPerPage, String id)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, CountPerPage);
		
		ArrayList<Message> list = mapper.sendlist(rb, id);
		
		return list;
	}
	
	public int deletereceiveMessage(Message message)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.deletereceiveMessage(message);
		
		return result;
	}
	
	public int deletesendMessage(Message message)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.deletesendMessage(message);
		
		return result;
	}
	
	public int alldeleteReceive(String receiver)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.alldeleteReceive(receiver);
		
		return result;
	}
	
	public int alldeleteSend(String sender)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		int result = mapper.alldeleteSend(sender);
		
		return result;
	}
	
	public List<Message> findreceivedMessage(int startRecode, int CountPerPage, String searchText)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, CountPerPage);
		
		List<Message> list = mapper.findreceivedMessage(rb, searchText);
		
		return list;
	}
	
	public List<Message> findsentMessage(int startRecode, int CountPerPage, String searchText)
	{
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, CountPerPage);
		
		List<Message> list = mapper.findsentMessage(rb, searchText);
		
		return list;
	}
	
	public void readCheck(int msgnum){
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		mapper.readCheck(msgnum);
	}
	
	public List<Message> newMessage(String id){
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		return mapper.newMessage(id);
	}
}