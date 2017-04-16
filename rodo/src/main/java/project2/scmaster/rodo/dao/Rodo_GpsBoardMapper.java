package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_GpsBoard;

public interface Rodo_GpsBoardMapper 
{
	public List<Rodo_GpsBoard> list(RowBounds rb, String searchText);
	
	public int listsize(String searchText);
	
	
}