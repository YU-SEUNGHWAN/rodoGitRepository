package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_GpsBoard;
import project2.scmaster.rodo.vo.Rodo_GpsReply;

public interface Rodo_GpsBoardMapper 
{
	public List<Rodo_GpsBoard> list(RowBounds rb, String searchText);
	
	public int listsize(String searchText);
	
	public int getsequence();
	
	public int writegps(Rodo_GpsBoard board);
	
	public int writegpsfile(Rodo_GpsBoard board);
	
	public Rodo_GpsBoard selectOne(int gps_boardnum);

	public void updateGps(Rodo_GpsBoard board);

	public int deletegps(int gps_boardnum);
	
	public int writegpsreply(Rodo_GpsReply reply);
	
	public int deletegpsreply(Rodo_GpsReply reply);
	
	public List<Rodo_GpsReply> findreply(int gps_boardnum);
	
	public int gpsreplylistsize(int gps_boardnum);
	
	public List<Rodo_GpsReply> getlist(RowBounds rb, int gps_boardnum);

	public int writegpsboardcount(String id);
	
	public List<Rodo_GpsBoard> mygpslist(RowBounds rb, String id);
}