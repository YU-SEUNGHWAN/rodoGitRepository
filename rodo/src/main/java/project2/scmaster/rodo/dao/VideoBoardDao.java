package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_VideoReply;
import project2.scmaster.rodo.vo.videoBoard;



@Repository
public class VideoBoardDao 
{
	@Autowired
	SqlSession sqlSession;
	
	public void write(videoBoard video){
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		mapper.write(video);
	}
	
	public int VideoSelelctBoardnum() {
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		int result = mapper.VideoSelelctBoardnum();
		System.out.println(result);
		return result;
	}

	
	/**
	 * 글 번호로 해당 게시글 읽기
	 * 
	 * @param boardnum
	 *            검색할 글번호
	 * @return 검색된 게시글 정보. 없으면 null.
	 */
	public videoBoard readVideo(int video_boardnum) {
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		// 해당 번호의 글정보 읽기
		videoBoard board = mapper.readVideo(video_boardnum);
		return board;
	}

	public int listsize(String searchText)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		int result = mapper.listsize(searchText);
		return result;
	}
	
	
	public ArrayList<videoBoard> Videolist(int startRecode, int countPerPage, String searchText) {
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		ArrayList<videoBoard> board = new ArrayList<>();
		board = mapper.Videolist(rb, searchText);
		return board;
	}
	
	public ArrayList<HashMap> VideoFileList(int photo_boardnum) {
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		ArrayList<HashMap> photoFile = new ArrayList<>();
		photoFile = mapper.VideoFileList(photo_boardnum);
		return photoFile;
	}
	
	public void deleteVideo(int Photo_boardnum){
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		mapper.deleteVideo(Photo_boardnum);
	}
	
	public int updateVideo(videoBoard board){
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		int doroku = 0;
		doroku = mapper.updateVideo(board);
		System.out.println(board.toString());
		return doroku;
	}
	
	
	
	
	public int writevideoreply(Rodo_VideoReply reply)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		
		int result = mapper.writevideoreply(reply);
		
		return result;
	}
	
	public List<Rodo_VideoReply> findreply(int video_boardnum)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		
		List<Rodo_VideoReply> list = mapper.findreply(video_boardnum);
		
		return list;
	}
	
	public int deletevideoreply(Rodo_VideoReply reply)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		
		int result = mapper.deletevideoreply(reply);
		
		return result;
	}
	
	public int videoreplylistsize(int video_boardnum)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		
		int result = mapper.videoreplylistsize(video_boardnum);
		
		return result;
	}
	
	public List<Rodo_VideoReply> getlist(int startRecode, int countPerPage, int video_boardnum)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
				
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<Rodo_VideoReply> list = mapper.getlist(rb, video_boardnum);
		
		return list;
	}
	
	public int writevideoboardcount(String id)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		
		int result = mapper.writevideoboardcount(id);
		
		return result;
	}
	
	public List<videoBoard> myvideolist(int startRecode, int countPerPage, String id)
	{
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		
		RowBounds rb = new RowBounds(startRecode, countPerPage);
		
		List<videoBoard> list = mapper.myvideolist(rb, id);
		
		return list;
	}
}