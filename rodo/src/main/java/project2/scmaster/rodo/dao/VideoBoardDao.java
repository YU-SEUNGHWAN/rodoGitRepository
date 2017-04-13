package project2.scmaster.rodo.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.videoBoard;


@Repository
public class VideoBoardDao 
{
	@Autowired
	SqlSession sqlsession;
	
	public void write(videoBoard video){
		
		VideoBoardMapper mapper = sqlsession.getMapper(VideoBoardMapper.class);
		
		mapper.write(video);
		
	}
	
}