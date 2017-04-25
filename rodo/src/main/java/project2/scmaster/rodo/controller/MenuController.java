package project2.scmaster.rodo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import project2.scmaster.rodo.dao.Rodo_GpsBoardDao;
import project2.scmaster.rodo.dao.Rodo_PhotoBoardDAO;
import project2.scmaster.rodo.dao.VideoBoardDao;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.vo.Rodo_GpsBoard;
import project2.scmaster.rodo.vo.Rodo_PhotoBoard;
import project2.scmaster.rodo.vo.videoBoard;

@Controller
public class MenuController {

	final int countPerPage = 4;		// 페이지 당 글 수
	final int pagePerGroup = 5;		// 페이지 이동 그룹 당 표시할 페이지 수
	
	@Autowired
	Rodo_PhotoBoardDAO photo_dao;
	
	@Autowired
	VideoBoardDao video_dao;
	
	@Autowired
	Rodo_GpsBoardDao gps_dao;
	
	@RequestMapping(value="index", method=RequestMethod.GET)
	public String bootstrap(){
		return "index";
	}
	
	@RequestMapping(value="photoBoard", method=RequestMethod.GET)
	public String photoBoard(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText
			)
	{
		int total = photo_dao.listsize(searchText);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		ArrayList<Rodo_PhotoBoard> pt_board = photo_dao.Photolist(navi.getStartRecord(), navi.getCountPerPage(), searchText);
		
		model.addAttribute("searchText", searchText);
		model.addAttribute("photoList", pt_board);
		model.addAttribute("navi", navi);
		
		return "photoBoard";
	}
	
	@RequestMapping(value="videoBoard", method=RequestMethod.GET)
	public String videoBoard(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText
			)
	{
		ArrayList<videoBoard> video_board = new ArrayList<>();
		
		int total = video_dao.listsize(searchText); 
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		video_board = video_dao.Videolist(navi.getStartRecord(), navi.getCountPerPage(), searchText);
		model.addAttribute("searchText", searchText);
		model.addAttribute("videoList", video_board);
		model.addAttribute("navi", navi);
		return "videoBoard";
	}
	
	@RequestMapping(value="logBoard", method=RequestMethod.GET)
	public String logBoard(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText
			){
		
		int total = gps_dao.listsize(searchText);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_GpsBoard> gpslist = gps_dao.list(navi.getStartRecord(), navi.getCountPerPage(), searchText);
		
		model.addAttribute("searchText", searchText);
		model.addAttribute("gpslist", gpslist);
		model.addAttribute("navi", navi);
		
		return "logBoard";
	}

	@RequestMapping(value="socketTest", method=RequestMethod.GET)
	public String socketTest()
	{
		
		return "socketTest";
	}
}