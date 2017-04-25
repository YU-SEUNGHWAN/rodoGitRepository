package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeReply;

public interface Rodo_FreeBoardMapper 
{
	public List<Rodo_FreeBoard> list(RowBounds rb, String searchText);
	
	public int write(Rodo_FreeBoard board);
	
	public int writefile(HashMap<String, Object> fileTable);
	
	public ArrayList<HashMap> FreeFileList(int free_boardnum);
	
	public Rodo_FreeBoard selectnofile(int free_boardnum);
	
	public Rodo_FreeBoard selectOne(int free_boardnum);
	
	public int getsequence();
	
	public void delete(int free_boardnum);
	
	public void hitup(Rodo_FreeBoard board);
	
	public void deleteFreeFile(int free_boardnum);
	
	public int updateFree(Rodo_FreeBoard board);
	
	public int updatefile(Rodo_FreeBoard board);
	
	public int writereply(Rodo_FreeReply reply);
	
	public List<Rodo_FreeReply> findreply(int free_boardnum);
	
	public Rodo_FreeReply selectreply(int freereply_replynum);

	public int deletereply(Rodo_FreeReply reply);
	
	public int listsize(String searchText);
}