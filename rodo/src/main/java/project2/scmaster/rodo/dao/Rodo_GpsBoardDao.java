package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_GpsBoard;

@Repository
public class Rodo_GpsBoardDao 
{
	@Autowired
	private SqlSession sqlsession;
	
	public List<Rodo_GpsBoard> list(int startRecode, int countPerPage, String searchText)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_GpsBoard> list = mapper.list(rb, searchText);
		
		return list;
	}
	
	public int listsize(String searchText)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.listsize(searchText);
		
		return result;
	}
	
	
}