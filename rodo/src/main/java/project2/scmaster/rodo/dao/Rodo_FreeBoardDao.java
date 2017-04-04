package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeFile;

@Repository
public class Rodo_FreeBoardDao 
{
	@Autowired
	SqlSession sqlsession;
	
	public List<Rodo_FreeBoard> list()
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		List<Rodo_FreeBoard> list = mapper.list();
		
		return list;
	}
	
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
}