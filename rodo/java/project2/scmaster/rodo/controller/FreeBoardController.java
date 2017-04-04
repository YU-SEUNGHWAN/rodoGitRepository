package project2.scmaster.rodo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project2.scmaster.rodo.dao.Rodo_FreeBoardDao;
import project2.scmaster.rodo.vo.Rodo_FreeBoard;

@Controller
public class FreeBoardController 
{
	@Autowired
	Rodo_FreeBoardDao dao;
	
	@RequestMapping(value = "freeboardlist", method = RequestMethod.GET)
	public String freeboardlist(Model model)
	{
		List<Rodo_FreeBoard> list = dao.list();
		
		model.addAttribute("list", list);
		
		return "freeboard/freeboardlist";
	}
	
	@RequestMapping(value = "freeboardwrite", method = RequestMethod.GET)
	public String freeboardwrite()
	{
		return "freeboard/freeboardwrite";
	}
	
	@RequestMapping(value = "freeboardwrite", method = RequestMethod.POST)
	public String freeboardwrite2(Rodo_FreeBoard board)
	{
		int result = dao.write(board);
		
		if (result != 1)
		{
			return "freeboard/freeboardwrite";
		}
		
		return "redirect:/freeboardlist";
	}
	
}