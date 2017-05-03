package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_QaBoard;
import project2.scmaster.rodo.vo.Rodo_QaReply;

@Repository
public class Rodo_QaBoardDao 
{
	@Autowired
	SqlSession sqlsession;
	
	/*public List<Rodo_QaBoard> list()
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		List<Rodo_QaBoard> list = mapper.list();
		
		return list;
	}*/
	
	public int write(Rodo_QaBoard board)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		int result = mapper.write(board);
		return result;
	}
	
	public int writefile(Rodo_QaBoard board)
	{
		int fileBoardnum = board.getQa_boardnum();
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		HashMap<String, Object> fileTable = new HashMap<String, Object>();
		int result = 0;
	
		System.out.println("프로필 칸 수" + board.getQafile_original().size());
		fileTable.put("qa_boardnum", fileBoardnum);
		
		for(int i = 0; i < board.getQafile_original().size(); i++)
		{
//			fileTable.put("qa_boardnum", board.getQafile_original().get(i));
			fileTable.put("qafile_original", board.getQafile_original().get(i));
			fileTable.put("qafile_saved", board.getQafile_saved().get(i));
			System.out.println("boardnum?" + board.getQa_boardnum());
			System.out.println(fileTable.get("qafile_original"));
			System.out.println(fileTable.get("qafile_saved"));
			System.out.println(fileTable.get("qa_boardnum"));

			result = mapper.writefile(fileTable);
		}
		return result;
	}
	
	public Rodo_QaBoard selectOne(int qa_boardnum)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		Rodo_QaBoard board = mapper.selectOne(qa_boardnum);
	
		return board;
	}
	
	public int getsequence()
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		int result = mapper.getsequence();
	
		return result;
	}
	
	public ArrayList<HashMap> QaFileList(int qa_boardnum)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		ArrayList<HashMap> qaFile = new ArrayList<>();
		qaFile = mapper.QaFileList(qa_boardnum);
		return qaFile;
	}
	
	public void delete(int qa_boardnum)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		mapper.deleteQaFile(qa_boardnum);
		mapper.delete(qa_boardnum);
	}
	
	
	
	public int updateqa (Rodo_QaBoard board)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		System.out.println(board.toString()+"받아온 board");
		
		int updateFileBoardnum = board.getQa_boardnum();
		int doroku = 0;
		
		HashMap<String, Object> fileTable2 = new HashMap<String, Object>();
		
		fileTable2.put("qa_boardnum", updateFileBoardnum);
			if(board.getQafile_original().size() != 0)
			{
				mapper.deleteQaFile(updateFileBoardnum);
				
				for(int i = 0; i<board.getQafile_original().size(); i++)
				{
					fileTable2.put("qafile_original", board.getQafile_original().get(i));
					fileTable2.put("qafile_saved", board.getQafile_saved().get(i));
					mapper.writefile(fileTable2);
				}
			}
			
			else
			{
				Rodo_QaBoard a = selectOne(board.getQa_boardnum()); 
				board.setQafile_original(a.getQafile_original());
				board.setQafile_saved(a.getQafile_saved());
				System.out.println(board.toString());
			}
		doroku = mapper.updateqa(board);
		return doroku;
	}
	
	public int updatefile(int qa_boardnum, Rodo_QaBoard board)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		int result = mapper.updatefile(qa_boardnum, board);
		return result;
	}
	
	public int writereply(Rodo_QaReply reply)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		int result = mapper.writereply(reply);
		
		return result;
	}
	
	public List<Rodo_QaReply> findreply(int qa_boardnum)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		List<Rodo_QaReply> list = mapper.findreply(qa_boardnum);
		
		return list;
	}
	
	
	public Rodo_QaReply selectreply(int Qareply_replynum)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		Rodo_QaReply reply = mapper.selectreply(Qareply_replynum);
		
		return reply;
	}
	
	public int deletereply(Rodo_QaReply reply)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		int result = mapper.deletereply(reply);
		
		return result;
	}
	
	public List<Rodo_QaBoard> list(int startRecode, int countPerPage, String searchText)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_QaBoard> list = mapper.list(rb, searchText);
		
		return list;
	}
	
	public int listsize(String searchText)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		int result = mapper.listsize(searchText);
		
		return result;
	}
	
	public void hitsPlus (int qa_boardnum)
	{
		Rodo_QaBoardMapper mapper = sqlsession.getMapper(Rodo_QaBoardMapper.class);
		
		mapper.hitsPlus(qa_boardnum);
	}
}
