package project2.scmaster.rodo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project2.scmaster.rodo.dao.Rodo_PhotoBoardDAO;
import project2.scmaster.rodo.vo.Rodo_PhotoBoard;

@Controller
public class MenuController {

	@Autowired
	Rodo_PhotoBoardDAO photo_dao;
	
	@RequestMapping(value="index", method=RequestMethod.GET)
	public String bootstrap(){
		return "index";
	}

	@RequestMapping(value="index2", method=RequestMethod.GET)
	public String index2(){
		
		return "index2";
	}
	
	@RequestMapping(value="photoBoard", method=RequestMethod.GET)
	public String photoBoard(Model model){
		ArrayList<Rodo_PhotoBoard> pt_board = new ArrayList<>(); 
		pt_board = photo_dao.Photolist();
		model.addAttribute("photoList", pt_board);
		return "photoBoard";
	}
	
	@RequestMapping(value="videoBoard", method=RequestMethod.GET)
	public String videoBoard(){
		return "videoBoard";
	}
	
	@RequestMapping(value="logBoard", method=RequestMethod.GET)
	public String logBoard(){
		
		return "logBoard";
	}

	@RequestMapping(value="socketTest", method=RequestMethod.GET)
	public String socketTest(){
		
		return "socketTest";
	}
}