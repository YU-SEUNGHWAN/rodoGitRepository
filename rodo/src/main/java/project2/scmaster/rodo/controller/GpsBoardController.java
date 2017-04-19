package project2.scmaster.rodo.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import project2.scmaster.rodo.dao.Rodo_GpsBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.util.Parsing;
import project2.scmaster.rodo.vo.GPX;
import project2.scmaster.rodo.vo.Rodo_GpsBoard;

@Controller
public class GpsBoardController 
{
	@Autowired
	private Rodo_GpsBoardDao dao;
	
	final String uploadPath = "/boardfile";
	
	@RequestMapping(value = "readGps", method = RequestMethod.GET)
	public String readGps(){
		
		return "readGps";
	}
	
	@RequestMapping(value = "writeGps", method = RequestMethod.GET)
	public String writeGps()
	{
		return "gps/writeGps";
	}
	
	@RequestMapping(value = "writeGps", method = RequestMethod.POST)
	public String writeGps2(Rodo_GpsBoard board, HttpSession session,
			MultipartFile upload)
	{	
		String id = (String)session.getAttribute("loginId");
		board.setGps_id(id);
		
		board.setGps_gpxinfo("info");
		board.setGps_location("tokyo");
		
		System.out.println(board.toString());
		
		int result = 0;
		
		System.out.println();
		System.out.println(result);
		System.out.println("글 잘 올라갔냐");
		
		if (!upload.isEmpty()) // upload != null 로 하면 안된다. 얘는 반드시 이렇게 써야 함
		{
			String savedfile = FileService.saveFile(upload, uploadPath);
			board.setGpsfile_original(upload.getOriginalFilename());
			board.setGpsfile_saved(savedfile);
			
			result = dao.writegps(board);
			
			return "redirect:/logBoard";
		}
		
		return "gps/writeGps";
	}
	
	@RequestMapping(value = "gpsread", method = RequestMethod.GET)
	public String gpsread(int gps_boardnum, Model model)
	{
		Rodo_GpsBoard board = dao.selectOne(gps_boardnum);
		
		if (board == null)
		{
			return "redirect:/logBoard";
		}
		
		model.addAttribute("gps_board", board);
		
		return "readGps";
	}
	
	
	@ResponseBody
	@RequestMapping(value="getGpsList", method=RequestMethod.GET)
	public ArrayList<GPX> getGpsList(){
		
		Parsing parsing = new Parsing();
		ArrayList<GPX> gpxList = parsing.GpxParse();
		
		return gpxList;
	}
}