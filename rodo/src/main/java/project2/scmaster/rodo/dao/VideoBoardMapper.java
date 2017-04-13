package project2.scmaster.rodo.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeReply;
import project2.scmaster.rodo.vo.videoBoard;

public interface VideoBoardMapper 
{

	public void write(videoBoard video);

}