package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_QaBoard;
import project2.scmaster.rodo.vo.Rodo_QaReply;

public interface Rodo_QaBoardMapper 
{
	public List<Rodo_QaBoard> list(RowBounds rb, String searchText);
	
	public int write(Rodo_QaBoard board);

	public int writefile (HashMap<String, Object> fileTable);

	public ArrayList<HashMap> QaFileList(int qa_boardnum);
	
	public Rodo_QaBoard selectOne(int qa_boardnum);
	
	public int getsequence();

	public void delete(int qa_boardnum);
	
	public void deleteQaFile (int qa_boardnum);
	
	public int updateqa(Rodo_QaBoard board);

	public int updatefile(int qa_boardnum, Rodo_QaBoard board);

	public int writereply(Rodo_QaReply reply);
	
	public List<Rodo_QaReply> findreply(int qa_boardnum);
	
	public Rodo_QaReply selectreply(int qareply_replynum);

	public int deletereply(Rodo_QaReply reply);
	
	public int listsize(String searchText);
	
	public int getReplyCount(int qa_boardnum);
	
	public int getMinReply();
	
	public int getFileCount(int qa_boardnum);
	
	public void hitsPlus(int qa_boardnum);
}