package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeReply;
import project2.scmaster.rodo.vo.Rodo_PhotoBoard;

@Repository
public class Rodo_FreeBoardDao{
	
	@Autowired
	SqlSession sqlsession;
	
	public int write(Rodo_FreeBoard board)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		int result = mapper.write(board);
		return result;
	}
	
	public int writefile(Rodo_FreeBoard board){
		int fileBoardnum = board.getFree_boardnum();
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		HashMap<String, Object> fileTable = new HashMap<String, Object>();
		int result = 0;
		System.out.println("프로필 칸 수" + board.getFreefile_original().size());
		fileTable.put("free_boardnum", fileBoardnum);
		for(int i = 0; i<board.getFreefile_original().size(); i++){
			fileTable.put("freefile_original", board.getFreefile_original().get(i));
			fileTable.put("freefile_saved", board.getFreefile_saved().get(i));
			System.out.println("다오 보드넘은?" + board.getFree_boardnum());
			System.out.println(fileTable.get("freefile_original"));
			System.out.println(fileTable.get("freefile_saved"));
			System.out.println(fileTable.get("free_boardnum"));
			result = mapper.writefile(fileTable);
		}
		return result;
	}
	
	public Rodo_FreeBoard selectOne(int free_boardnum)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		Rodo_FreeBoard board = mapper.selectOne(free_boardnum);
		return board;
	}
	
	public void hitup(Rodo_FreeBoard board)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		mapper.hitup(board);
	}
	
	public int getsequence(){
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		int result = mapper.getsequence();
		return result;
	}
	
	public ArrayList<HashMap> FreeFileList(int free_boardnum) {
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		ArrayList<HashMap> freeFile = new ArrayList<>();
		freeFile = mapper.FreeFileList(free_boardnum);
		return freeFile;
	}
	
	
	public void delete(int free_boardnum)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		mapper.deleteFreeFile(free_boardnum);
		mapper.delete(free_boardnum);
	}
	
	public int updateFree(Rodo_FreeBoard board)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		System.out.println(board.toString());
		int updateFileBoardnum = board.getFree_boardnum();
		int doroku = 0;
		HashMap<String, Object> fileTable = new HashMap<String, Object>();
		fileTable.put("free_boardnum", updateFileBoardnum);
			if(board.getFreefile_original().size()!=0){
				mapper.deleteFreeFile(updateFileBoardnum);
				for(int i = 0; i<board.getFreefile_original().size(); i++){
					fileTable.put("freefile_original", board.getFreefile_original().get(i));
					fileTable.put("freefile_saved", board.getFreefile_saved().get(i));
					mapper.writefile(fileTable);
				}
			}else{
				Rodo_FreeBoard a = selectOne(board.getFree_boardnum()); 
				board.setFreefile_original(a.getFreefile_original());
				board.setFreefile_saved(a.getFreefile_saved());
				System.out.println(board.toString());
			}
		doroku = mapper.updateFree(board);
		return doroku;
	}
	
	public int updatefile(Rodo_FreeBoard board)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		int result = mapper.updatefile(board);
		return result;
	}
	
	public int writereply(Rodo_FreeReply reply)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		int result = mapper.writereply(reply);
		return result;
	}
	
	public List<Rodo_FreeReply> findreply(int free_boardnum)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		List<Rodo_FreeReply> list = mapper.findreply(free_boardnum);
		return list;
	}
	
	public Rodo_FreeReply selectreply(int freereply_replynum)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		Rodo_FreeReply reply = mapper.selectreply(freereply_replynum);
		return reply;
	}
	
	public int deletereply(Rodo_FreeReply reply)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		int result = mapper.deletereply(reply);
		return result;
	}
	
	public List<Rodo_FreeBoard> list(int startRecode, int countPerPage, String searchText)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		List<Rodo_FreeBoard> list = mapper.list(rb, searchText);
		
		return list;
	}
	
	public int listsize(String searchText)	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		int result = mapper.listsize(searchText);
		return result;
	}
	
	public int freereplylistsize(int free_boardnum)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.freereplylistsize(free_boardnum);
		
		return result;
	}
	
	public List<Rodo_FreeReply> getlist(int startRecode, int countPerPage, int free_boardnum)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_FreeReply> list = mapper.getlist(rb, free_boardnum);
		
		return list;
	}
	
	public int writefreeboardcount(String id)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		int result = mapper.writefreeboardcount(id);
		
		return result;
	}
	
	public List<Rodo_FreeBoard> myfreelist(int startRecode, int countPerPage, String id)
	{
		Rodo_FreeBoardMapper mapper = sqlsession.getMapper(Rodo_FreeBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_FreeBoard> list = mapper.myfreelist(rb, id);
		
		return list;
	}
	
}