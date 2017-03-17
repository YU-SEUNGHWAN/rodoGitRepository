package project2.scmaster.rodo.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import project2.scmaster.rodo.util.Parsing;
import project2.scmaster.rodo.vo.GPX;

@Controller
public class MemberController {	
	
	@RequestMapping(value="MapTest", method=RequestMethod.GET)
	public String MapTest(){
		
		return "MapTest";
	}
	
	@ResponseBody
	@RequestMapping(value="getGpsList", method=RequestMethod.GET)
	public ArrayList<GPX> getGpsList(){
		
		Parsing parsing = new Parsing();
		ArrayList<GPX> gpxList = parsing.GpxParse();
		
		return gpxList;
	}
	
}
