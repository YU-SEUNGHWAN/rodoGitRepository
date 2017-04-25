package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_GpsBoard;

public interface Rodo_GpsBoardMapper 
{
	public List<Rodo_GpsBoard> list(RowBounds rb, String searchText);
	
	public int listsize(String searchText);
	
	public int getsequence();
	
	public int writegps(Rodo_GpsBoard board);
	
	public int writegpsfile(Rodo_GpsBoard board);
	
	public Rodo_GpsBoard selectOne(int gps_boardnum);

	public void updateGps(Rodo_GpsBoard board);
}