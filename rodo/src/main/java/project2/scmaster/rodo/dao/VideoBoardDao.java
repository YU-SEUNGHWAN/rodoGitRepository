package project2.scmaster.rodo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Rodo_PhotoBoard;
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

	/*public int VideofileInsertBoard(videoBoard board) {
		System.out.println(board.toString());
		int fileBoardnum = board.getPhoto_boardnum();
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
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
			result = mapper.VideofileInsertBoard(fileTable);
		}
		return result;
	}*/

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

	public ArrayList<videoBoard> Videolist() {
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
		ArrayList<videoBoard> board = new ArrayList<>();
		board = mapper.Videolist();
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
		mapper.deleteVideoFile(Photo_boardnum);
		mapper.deleteVideo(Photo_boardnum);
	}
	
	/*public int updateVideo(videoBoard board){
		VideoBoardMapper mapper = sqlSession.getMapper(VideoBoardMapper.class);
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
				videoBoard a = readPhoto(board.getPhoto_boardnum());
				 board.setPhotofile_tn(a.getPhotofile_tn());
				 System.out.println(board.toString());
			}
		doroku = mapper.updatePhoto(board);
		return doroku;
	}*/
	
	
	
}