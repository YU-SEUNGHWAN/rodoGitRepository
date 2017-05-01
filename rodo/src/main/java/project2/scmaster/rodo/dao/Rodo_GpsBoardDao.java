package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_GpsBoard;
import project2.scmaster.rodo.vo.Rodo_GpsReply;

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
	
	public int getsequence()
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.getsequence();
		
		return result;
	}
	
	public int writegps(Rodo_GpsBoard board)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.writegps(board);
		
		return result;
	}
	
	public int writegpsfile(Rodo_GpsBoard board)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.writegpsfile(board);
		
		return result;
	}
	
	public Rodo_GpsBoard selectOne(int gps_boardnum)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		Rodo_GpsBoard board = mapper.selectOne(gps_boardnum);
		
		return board;
	}
	
	public void updateGps(Rodo_GpsBoard board){
		
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		mapper.updateGps(board);
		
	}
	
	public int deletegps(int gps_boardnum)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.deletegps(gps_boardnum);
		
		return result;
	}
	
	public int writegpsreply(Rodo_GpsReply reply)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.writegpsreply(reply);
		
		return result;
	}
	
	public List<Rodo_GpsReply> findreply(int gps_boardnum)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		List<Rodo_GpsReply> list = mapper.findreply(gps_boardnum);
		
		return list;
	}
	
	public int deletegpsreply(Rodo_GpsReply reply)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.deletegpsreply(reply);
		
		return result;
	}
	
	public int gpsreplylistsize(int gps_boardnum)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.gpsreplylistsize(gps_boardnum);
		
		return result;
	}
	
	public List<Rodo_GpsReply> getlist(int startRecode, int countPerPage, int gps_boardnum)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_GpsReply> list = mapper.getlist(rb, gps_boardnum);
		
		return list;
	}	
	
	public int writegpsboardcount(String id)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		int result = mapper.writegpsboardcount(id);
		
		return result;
	}
	
	public List<Rodo_GpsBoard> mygpslist(int startRecode, int countPerPage, String id)
	{
		Rodo_GpsBoardMapper mapper = sqlsession.getMapper(Rodo_GpsBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_GpsBoard> list = mapper.mygpslist(rb, id);
		
		return list;
	}
}