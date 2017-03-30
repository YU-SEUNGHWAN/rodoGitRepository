package project2.scmaster.rodo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MenuController {

	@RequestMapping(value="bootstrap", method=RequestMethod.GET)
	public String bootstrap(){
		
		return "index";
	}

	@RequestMapping(value="test", method=RequestMethod.GET)
	public String test(){
		
		return "test1";
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
	
}