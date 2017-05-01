package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_PhotoBoard;
import project2.scmaster.rodo.vo.Rodo_PhotoReply;

/**
 * 게시판 관련 DAO
 */
@Repository
public class Rodo_PhotoBoardDAO {
	@Autowired
	SqlSession sqlSession;

	/**
	 * 게시글 저장
	 * @param board
	 *            저장할 게시글 정보
	 */
	public int PhotoInsertBoard(Rodo_PhotoBoard board) {
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		int result = mapper.PhotoInsertBoard(board);
		return result;
	}

	public int PhotoSelelctBoardnum() {
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		int result = mapper.PhotoSelelctBoardnum();
		System.out.println(result);
		return result;
	}

	public int PhotofileInsertBoard(Rodo_PhotoBoard board) {
		System.out.println(board.toString());
		int fileBoardnum = board.getPhoto_boardnum();
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		//int result = mapper.PhotoInsertBoard(board);
		
		HashMap<String, Object> fileTable = new HashMap<String, Object>();
		int result = 0;
		System.out.println("프로필 칸 수" + board.getPhotofile_original().size());
		fileTable.put("photo_boardnum", fileBoardnum);
		for(int i = 0; i<board.getPhotofile_original().size(); i++){
			fileTable.put("photofile_original", board.getPhotofile_original().get(i));
			fileTable.put("photofile_saved", board.getPhotofile_saved().get(i));
			System.out.println("다오 보드넘은?" + board.getPhoto_boardnum());
			System.out.println(fileTable.get("photofile_original"));
			System.out.println(fileTable.get("photofile_saved"));
			System.out.println(fileTable.get("photo_boardnum"));
			result = mapper.PhotofileInsertBoard(fileTable);
		}
		return result;
	}

	/**
	 * 글 번호로 해당 게시글 읽기
	 * 
	 * @param boardnum
	 *            검색할 글번호
	 * @return 검색된 게시글 정보. 없으면 null.
	 */
	public Rodo_PhotoBoard readPhoto(int photo_boardnum) {
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		// 해당 번호의 글정보 읽기
		Rodo_PhotoBoard board = mapper.readPhoto(photo_boardnum);
		return board;
	}

	public ArrayList<Rodo_PhotoBoard> Photolist(int startRecode, int countPerPage, String searchText){
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		ArrayList<Rodo_PhotoBoard> board = mapper.Photolist(rb, searchText);
		return board;
	}
	
	public ArrayList<HashMap> PhotoFileList(int photo_boardnum) {
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		ArrayList<HashMap> photoFile = new ArrayList<>();
		photoFile = mapper.PhotoFileList(photo_boardnum);
		return photoFile;
	}
	
	public void deletePhoto(int Photo_boardnum){
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		mapper.deletePhotoFile(Photo_boardnum);
		mapper.deletePhoto(Photo_boardnum);
	}
	
	public int updatePhoto(Rodo_PhotoBoard board){
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		System.out.println(board.toString());
		int updateFileBoardnum = board.getPhoto_boardnum();
		int doroku = 0;
		HashMap<String, Object> fileTable = new HashMap<String, Object>();
		fileTable.put("photo_boardnum", updateFileBoardnum);
			if(board.getPhotofile_original().size()!=0){
				mapper.deletePhotoFile(updateFileBoardnum);
				for(int i = 0; i<board.getPhotofile_original().size(); i++){
					fileTable.put("photofile_original", board.getPhotofile_original().get(i));
					fileTable.put("photofile_saved", board.getPhotofile_saved().get(i));
					mapper.PhotofileInsertBoard(fileTable);
				}
			}else{
				 Rodo_PhotoBoard a = readPhoto(board.getPhoto_boardnum());
				 board.setPhotofile_tn(a.getPhotofile_tn());
				 System.out.println(board.toString());
			}
		doroku = mapper.updatePhoto(board);
		return doroku;
	}
	
	public int listsize(String searchText)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		int result = mapper.listsize(searchText);
		
		return result;
	}
	
	public int writephotoreply(Rodo_PhotoReply reply)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		int result = mapper.writephotoreply(reply);
		
		return result;
	}
	
	public List<Rodo_PhotoReply> findreply(int photo_boardnum)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		List<Rodo_PhotoReply> list = mapper.findreply(photo_boardnum);
		
		return list;
	}
	
	public int deletereply(Rodo_PhotoReply reply)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		int result = mapper.deletereply(reply);
		
		return result;
	}
	
	public int photoreplylistsize(int photo_boardnum)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		int result = mapper.photoreplylistsize(photo_boardnum);
		
		return result;
	}
	
	public List<Rodo_PhotoReply> getlist(int startRecode, int countPerPage, int photo_boardnum)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_PhotoReply> list = mapper.getlist(rb, photo_boardnum);
		
		return list;
	}
	
	public int writephotoboardcount(String id)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		int result = mapper.writephotoboardcount(id);
		
		return result;
	}
	
	public List<Rodo_PhotoBoard> myphotolist(int startRecode, int countPerPage, String id)
	{
		Rodo_PhotoBoardMapper mapper = sqlSession.getMapper(Rodo_PhotoBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_PhotoBoard> list = mapper.myphotolist(rb, id);
		
		return list;
	}
}