package project2.scmaster.rodo.dao;

import java.util.List;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;

public interface Rodo_FreeBoardMapper 
{
	public List<Rodo_FreeBoard> list();
	
	public int write(Rodo_FreeBoard board);
	
	public int writefile();
}