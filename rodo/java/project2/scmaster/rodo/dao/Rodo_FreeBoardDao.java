package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;

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
}
