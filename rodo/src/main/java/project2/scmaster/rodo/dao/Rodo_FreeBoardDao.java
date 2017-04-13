package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeReply;

@Repository
public class Rodo_FreeBoardDao 
{
	@Autowired
	SqlSession sqlsession;
	
	/*public List<Rodo_FreeBoard> list()
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		List<Rodo_FreeBoard> list = mapper.list();
		
		return list;
	}*/
	
	public int write(Rodo_FreeBoard board)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.write(board);
		
		return result;
	}
	
	public int writefile(Rodo_FreeBoard board)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.writefile(board);
		
		return result;
	}
	
	/*public int writefile(HashMap<String, Object> map)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.writefile(map);
		
		return result;
	}*/
	
	public Rodo_FreeBoard selectOne(int free_boardnum)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		Rodo_FreeBoard board = mapper.selectOne(free_boardnum);
	
		return board;
	}
	
	public int getsequence(){
		
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.getsequence();
	
		return result;
	}
	
	public int delete(Rodo_FreeBoard board)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.delete(board);
		
		return result;
	}
	
	public int update(Rodo_FreeBoard board)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.update(board);
		
		return result;
	}
	
	public int updatefile(Rodo_FreeBoard board)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.updatefile(board);
		
		return result;
	}
	
	public int writereply(Rodo_FreeReply reply)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.writereply(reply);
		
		return result;
	}
	
	public List<Rodo_FreeReply> findreply(int free_boardnum)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		List<Rodo_FreeReply> list = mapper.findreply(free_boardnum);
		
		return list;
	}
	
	public Rodo_FreeBoard selectnofile(int free_boardnum)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		Rodo_FreeBoard board = mapper.selectnofile(free_boardnum);
		
		return board;
	}
	
	public Rodo_FreeReply selectreply(int freereply_replynum)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		Rodo_FreeReply reply = mapper.selectreply(freereply_replynum);
		
		return reply;
	}
	
	public int deletereply(Rodo_FreeReply reply)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.deletereply(reply);
		
		return result;
	}
	
	public List<Rodo_FreeBoard> list(int startRecode, int countPerPage, String searchText)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_FreeBoard> list = mapper.list(rb, searchText);
		
		return list;
	}
	
	public int listsize(String searchText)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.listsize(searchText);
		
		return result;
	}
}