package project2.scmaster.rodo.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Board;


/**
 * 게시판 관련 DAO
 */
@Repository
public class PhotoBoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 게시글 저장
	 * @param board 저장할 게시글 정보
	 */
	public int Photoinsert(Board board) {
		PhotoBoardMapper mapper = sqlSession.getMapper(PhotoBoardMapper.class);
		
		int result = 0;
		try {
			result = mapper.PhotoInsertBoard(board);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 글 번호로 해당 게시글 읽기
	 * @param boardnum 검색할 글번호
	 * @return 검색된 게시글 정보. 없으면 null.
	 */
	public Board Photoget(int boardnum) {
		PhotoBoardMapper mapper = sqlSession.getMapper(PhotoBoardMapper.class);
		//해당 번호의 글정보 읽기
		Board board = mapper.PhotoGetBoard(boardnum);
		return board;
	}
	
	public int selelctPhotoBoardnum(){
		PhotoBoardMapper mapper = sqlSession.getMapper(PhotoBoardMapper.class);
		int result = mapper.PhotoSelelctBoardnum();
		return result;
	}

	public ArrayList<Board> Photolist(){
		PhotoBoardMapper mapper = sqlSession.getMapper(PhotoBoardMapper.class);
		ArrayList<Board> board = new ArrayList<>();
		board = mapper.PhotoList();
		return board;
	}
	
}