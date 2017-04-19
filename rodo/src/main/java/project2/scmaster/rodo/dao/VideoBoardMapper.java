package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_VideoReply;
import project2.scmaster.rodo.vo.videoBoard;

public interface VideoBoardMapper{

	public void write(videoBoard video);
	//게시글 저장
	public int VideoInsertBoard(videoBoard board);
	//방금 등록한 게시글 번호 가져오기
	public int VideoSelelctBoardnum();
	//글번호에 해당하는 파일 저장.
	public int VideofileInsertBoard(HashMap<String, Object> fileTable);
	
	//글번호로 해당 게시글 검색
	public videoBoard readVideo(int video_boardnum);

	public ArrayList<videoBoard> Videolist(RowBounds rb, String searchText);
	
	public ArrayList<HashMap> VideoFileList(int photo_boardnum);

	public int listsize(String searchText);
	
	public void deleteVideo(int video_boardnum);
	
	public void deleteVideoFile(int photo_boardnum);
	
	public int updateVideo(videoBoard board);
	
	public int writevideoreply(Rodo_VideoReply reply);
	
	public List<Rodo_VideoReply> findreply(int video_boardnum);
	
	public int deletevideoreply(Rodo_VideoReply reply);
}