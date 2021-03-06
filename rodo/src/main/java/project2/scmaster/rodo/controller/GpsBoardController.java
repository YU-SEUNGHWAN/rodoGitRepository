package project2.scmaster.rodo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.dao.Rodo_GpsBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.util.Parsing;
import project2.scmaster.rodo.vo.GPX;
import project2.scmaster.rodo.vo.Rodo_GpsBoard;
import project2.scmaster.rodo.vo.Rodo_GpsReply;

@Controller
public class GpsBoardController 
{
	@Autowired
	private Rodo_GpsBoardDao dao;
	
	final String uploadPath = "/boardfile";
	final int countPerPage = 8;		// 페이지 당 글 수
	final int pagePerGroup = 5;		// 페이지 이동 그룹 당 표시할 페이지 수
	
	
	@RequestMapping(value = "writeGps", method = RequestMethod.GET)
	public String writeGps()
	{
		return "gps/writeGps";
	}
	
	@RequestMapping(value="logBoard", method=RequestMethod.GET)
	public String logBoard(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText
			){
		
		int total = dao.listsize(searchText);
		
		if (total == 0)
		{
			total = 1;
		}
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_GpsBoard> gpslist = dao.list(navi.getStartRecord(), navi.getCountPerPage(), searchText);
		
		model.addAttribute("searchText", searchText);
		model.addAttribute("gpslist", gpslist);
		model.addAttribute("navi", navi);
		
		return "gps/logBoard";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "writeGps", method = RequestMethod.POST)
	public void writeGps2(Rodo_GpsBoard board, HttpSession session,
			MultipartHttpServletRequest request){	
		
		String originalFile = null;
		String savedFile = null;
		
		String id = (String)session.getAttribute("loginId");
		board.setGps_id(id);
		
		board.setGps_gpxinfo("info");
	//	board.setGps_location("tokyo");
		
		System.out.println(board.toString());
		
		Iterator<String> itr = request.getFileNames();

		if (itr.hasNext()) {
			MultipartFile mpf = request.getFile(itr.next());
			originalFile = mpf.getOriginalFilename();
			try {
				System.out.println("file length : " + mpf.getBytes().length);
				System.out.println("file name : " + mpf.getOriginalFilename());

				if (!mpf.isEmpty()) {
					savedFile = FileService.saveFile(mpf, uploadPath);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		board.setGpsfile_original(originalFile);
		board.setGpsfile_saved(savedFile);
		dao.writegps(board);
		
	}
	
	
	
	@RequestMapping(value = "gpsread", method = RequestMethod.GET)
	public String gpsread(int gps_boardnum, Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{	
		int total = dao.gpsreplylistsize(gps_boardnum);
		
	//	String id = (String)session.getAttribute("loginId");
		
		if (total == 0)
		{
			total = 1;
		}
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_GpsReply> gpsreplylist = dao.getlist(navi.getStartRecord(), navi.getCountPerPage(), gps_boardnum);
		
		Rodo_GpsBoard board = dao.selectOne(gps_boardnum);
		
		if (board == null)
		{
			return "redirect:/logBoard";
		}
		
		model.addAttribute("gps_board", board);
		model.addAttribute("myMarks", board.getGps_marker());
		model.addAttribute("gpsreplylist", gpsreplylist);
		model.addAttribute("navi", navi);

		return "gps/readGps";
	}
	
	
	@ResponseBody
	@RequestMapping(value="getGpsList", method=RequestMethod.GET)
	public ArrayList<GPX> getGpsList(String savedfile){
		
		Parsing parsing = new Parsing();
		ArrayList<GPX> gpxList = parsing.GpxParse(uploadPath+"/"+savedfile);
		
		return gpxList;
	}
		
	
	@ResponseBody
	@RequestMapping(value="getTempMap", method=RequestMethod.POST)	
	public ArrayList<GPX> getTempMap(MultipartHttpServletRequest request, HttpServletResponse response){
		
		String tempPath = request.getServletContext().getRealPath("/resources/thumbgpx/");
		String fullPath = null;

		Iterator<String> itr = request.getFileNames();

		if (itr.hasNext()) {
			MultipartFile mpf = request.getFile(itr.next());
			System.out.println(mpf.getOriginalFilename() + " uploaded!");
			try {
				System.out.println("file length : " + mpf.getBytes().length);
				System.out.println("file name : " + mpf.getOriginalFilename());

				if (!mpf.isEmpty()) {
					fullPath = tempPath + FileService.saveFile(mpf, tempPath);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		Parsing parsing = new Parsing();
		ArrayList<GPX> gpxList = parsing.GpxParse(fullPath);
		
		return gpxList;
	}
	
	@RequestMapping(value="gpsUpdate", method=RequestMethod.GET)
	public String gpsUpdate(int boardnum, Model model){
		
		Rodo_GpsBoard board = dao.selectOne(boardnum);
		
		model.addAttribute("gpsboard", board);
		
		return "gps/updateGps";
	}

	@ResponseBody
	@RequestMapping(value="updateGps", method=RequestMethod.POST)
	public void updateGps(Rodo_GpsBoard board, HttpSession session,
			MultipartHttpServletRequest request){
		
		String originalFile = null;
		String savedFile = null;
		
		String id = (String)session.getAttribute("loginId");
		board.setGps_id(id);
		
		board.setGps_gpxinfo("info");
	//	board.setGps_location("tokyo");
		
		System.out.println(board.getGps_marker());
		
		Iterator<String> itr = request.getFileNames();

		if (itr.hasNext()) {
			MultipartFile mpf = request.getFile(itr.next());
			originalFile = mpf.getOriginalFilename();
			try {
				System.out.println("file length : " + mpf.getBytes().length);
				System.out.println("file name : " + mpf.getOriginalFilename());

				if (!mpf.isEmpty()) {
					savedFile = FileService.saveFile(mpf, uploadPath);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		board.setGpsfile_original(originalFile);
		board.setGpsfile_saved(savedFile);
		dao.updateGps(board);
	}
	
	@RequestMapping(value = "deletegps", method = RequestMethod.GET)
	public String deletegps(int gps_boardnum)
	{
		Rodo_GpsBoard board = dao.selectOne(gps_boardnum);
		
		List<Rodo_GpsReply> gpsreplylist = dao.findreply(gps_boardnum);
		
		if (gpsreplylist != null)
		{
			for (int i=0; i<gpsreplylist.size(); i++)
			{
				dao.deletegpsreply(gpsreplylist.get(i));
			}
		}
		
		FileService.deleteFile(board.getGpsfile_original());
		
		dao.deletegps(gps_boardnum);
		
		return "redirect:logBoard";
	}
	
	@ResponseBody
	@RequestMapping(value = "writegpsreply", method = RequestMethod.POST)
	public HashMap<?, ?> writegpsreply(Rodo_GpsReply reply, Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{	
		String id = (String)session.getAttribute("loginId");
		reply.setGpsreply_id(id);
		
		dao.writegpsreply(reply);
		
		int total = dao.gpsreplylistsize(reply.getGps_boardnum());
		
		if (total == 0)
		{
			total = 1;
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_GpsReply> gpsreplylist = dao.getlist(navi.getStartRecord(), navi.getCountPerPage(), reply.getGps_boardnum());
		
		map.put("navi", navi);
		map.put("gpsreplylist", gpsreplylist);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "deletegpsreply", method = RequestMethod.POST)
	public HashMap<?, ?> deletegpsreply(Rodo_GpsReply reply, Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{
		String id = (String)session.getAttribute("loginId");
		reply.setGpsreply_id(id);
		
		dao.deletegpsreply(reply);
		
		int total = dao.gpsreplylistsize(reply.getGps_boardnum());
		
		if (total == 0)
		{
			total = 1;
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_GpsReply> gpsreplylist = dao.getlist(navi.getStartRecord(), navi.getCountPerPage(), reply.getGps_boardnum());
		
		map.put("navi", navi);
		map.put("gpsreplylist", gpsreplylist);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "replygpspage", method = RequestMethod.POST)
	public HashMap<?, ?> gpspage(Rodo_GpsReply reply, Model model,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{
		int total = dao.gpsreplylistsize(reply.getGps_boardnum());
		
		if (total == 0)
		{
			total = 1;
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_GpsReply> gpsreplylist = dao.getlist(navi.getStartRecord(), navi.getCountPerPage(), reply.getGps_boardnum());
		
		map.put("navi", navi);
		map.put("gpsreplylist", gpsreplylist);
				
		return map;	
	}
}