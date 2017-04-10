package project2.scmaster.rodo.dao;


import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Message;

@Repository
public class MessageDao implements MessageMapper{
	@Autowired
	private SqlSession session;
	
	@Override
	public void writeMessage(Message message) {
	
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		mapper.writeMessage(message);

	}

	@Override
	public ArrayList<Message> receivedMessage(String id) {

		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		return mapper.receivedMessage(id);
	}

	@Override
	public ArrayList<Message> newMessage(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Message> sentMessage(String id) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		return mapper.sentMessage(id);
	}

	@Override
	public Message readMessage(int messagenum) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		return mapper.readMessage(messagenum);
	}
	
}