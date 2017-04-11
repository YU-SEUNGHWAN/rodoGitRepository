package project2.scmaster.rodo.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import project2.scmaster.rodo.util.Parsing;
import project2.scmaster.rodo.vo.GPX;

@Controller
public class PhotoBoardController {

	@RequestMapping(value = "readPhoto", method = RequestMethod.GET)
	public String readGps(){
		
		return "readPhoto";
	}
	
	
}
