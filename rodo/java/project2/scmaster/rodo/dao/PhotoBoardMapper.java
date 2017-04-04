package project2.scmaster.rodo.dao;

import java.util.ArrayList;

import project2.scmaster.rodo.vo.Board;

/**
 * 게시판 관련 Mybatis 사용 메서드
 */
public interface PhotoBoardMapper {
	//게시글 저장
	public int PhotoInsertBoard(Board board);
	//글번호로 해당 게시글 검색
	public Board PhotoGetBoard(int boardnum);
	
	public int PhotoSelelctBoardnum();

	public ArrayList<Board> PhotoList();
}
