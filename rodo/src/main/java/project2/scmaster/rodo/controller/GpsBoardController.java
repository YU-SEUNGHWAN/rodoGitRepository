package project2.scmaster.rodo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import project2.scmaster.rodo.dao.Rodo_GpsBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.util.Parsing;
import project2.scmaster.rodo.vo.GPX;
import project2.scmaster.rodo.vo.Marks;
import project2.scmaster.rodo.vo.Rodo_GpsBoard;

@Controller
public class GpsBoardController 
{
	@Autowired
	private Rodo_GpsBoardDao dao;
	
	final String uploadPath = "/boardfile";
	
	
	@RequestMapping(value = "writeGps", method = RequestMethod.GET)
	public String writeGps()
	{
		return "gps/writeGps";
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
		board.setGps_location("tokyo");
		
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
	public String gpsread(int gps_boardnum, Model model)
	{
		Rodo_GpsBoard board = dao.selectOne(gps_boardnum);
		if (board == null){
			return "redirect:/logBoard";
		}

		model.addAttribute("gps_board", board);
		model.addAttribute("myMarks", board.getGps_marker());
		
		return "readGps";
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
		board.setGps_location("tokyo");
		
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
		System.out.println("지나감");
	}
}