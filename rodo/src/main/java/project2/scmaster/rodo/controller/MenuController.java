package project2.scmaster.rodo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MenuController {

	@RequestMapping(value="index", method=RequestMethod.GET)
	public String bootstrap(){
		
		return "member/index";
	}

	@RequestMapping(value="index2", method=RequestMethod.GET)
	public String index2(){
		
		return "index2";
	}
	
	@RequestMapping(value="photoBoard", method=RequestMethod.GET)
	public String photoBoard(){
		
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
