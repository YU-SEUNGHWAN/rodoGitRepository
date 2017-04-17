package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_PhotoBoard;
import project2.scmaster.rodo.vo.Rodo_PhotoReply;

/**
 * 게시판 관련 Mybatis 사용 메서드
 */
public interface Rodo_PhotoBoardMapper 
{
	//게시글 저장
	public int PhotoInsertBoard(Rodo_PhotoBoard board);
	//방금 등록한 게시글 번호 가져오기
	public int PhotoSelelctBoardnum();
	//글번호에 해당하는 파일 저장.
	public int PhotofileInsertBoard(HashMap<String, Object> fileTable);
	
	//글번호로 해당 게시글 검색
	public Rodo_PhotoBoard readPhoto(int photo_boardnum);

	public ArrayList<Rodo_PhotoBoard> Photolist(RowBounds rb, String searchText);
	
	public ArrayList<HashMap> PhotoFileList(int photo_boardnum);

	public void deletePhoto(int photo_boardnum);
	
	public void deletePhotoFile(int photo_boardnum);
	
	public int updatePhoto(Rodo_PhotoBoard board);
	
	public int listsize(String searchText);
	
	public int writephotoreply(Rodo_PhotoReply reply);

	public List<Rodo_PhotoReply> findreply(int photo_boardnum);
	
	public int deletereply(Rodo_PhotoReply reply);
}