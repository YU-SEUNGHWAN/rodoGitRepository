package project2.scmaster.rodo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeFile;

public interface Rodo_FreeBoardMapper 
{
	public List<Rodo_FreeBoard> list();
	
	public int write(Rodo_FreeBoard board);
	
	public int writefile(Rodo_FreeBoard board);
	
//	public int writefile(HashMap<String, Object> map);

	
	
	public Rodo_FreeBoard selectOne(int free_boardnum);
	
	public int getsequence();
	
	public int delete(Rodo_FreeBoard board);
	
	public int update(Rodo_FreeBoard board);
	
	public int updatefile(Rodo_FreeBoard board);
}