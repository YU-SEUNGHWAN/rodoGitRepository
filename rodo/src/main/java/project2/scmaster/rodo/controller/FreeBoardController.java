package project2.scmaster.rodo.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.dao.Rodo_FreeBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeReply;


@Controller
public class FreeBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(FreeBoardController.class);
	final int countPerPage = 15;		// 페이지 당 글 수
	final int pagePerGroup = 5;		// 페이지 이동 그룹 당 표시할 페이지 수
	
	@Autowired
	Rodo_FreeBoardDao dao;
	
	final String uploadPath = "/boardfile";
	
	@RequestMapping(value = "freeboardlist", method = RequestMethod.GET)
	public String freeboardlist(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText
			)
	{
		int total = dao.listsize(searchText);
		
		System.out.println(total);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<Rodo_FreeBoard> list = dao.list(navi.getStartRecord(), navi.getCountPerPage(), searchText);
		
		model.addAttribute("searchText", searchText);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		
		return "freeboard/freeboardlist";
	}
	
	@RequestMapping(value = "freeboardwrite", method = RequestMethod.GET)
	public String freeboardwrite()	{
		return "freeboard/freeboardwrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "writeFree", method = RequestMethod.POST)
	public String freeboardwrite2(Rodo_FreeBoard board, HttpSession session, Model model, 
			MultipartHttpServletRequest request, HttpServletResponse response)	{
		String id = (String)session.getAttribute("loginId");
		board.setFree_id(id);
		
		Iterator<String> itr = request.getFileNames();
		
		String OriginalFilename = ""; // 내가 저장할 파일의 이름.(hi.jpg)
		String Serversavedfile = ""; // 서버에 저장할 날짜로 이름이 바뀌어 저장되는
										// 파일.(170329//////////////////)
		
		ArrayList<String> originalFile = new ArrayList<>(); // vo에 담을 OriginalFile
		ArrayList<String> savedFile = new ArrayList<>(); // vo에 담을 SavedFile
		
		while (itr.hasNext()) { //만약 파일이 있다면
			MultipartFile mpf = request.getFile(itr.next()); // 리퀘스트에서 파일을 하나씩 가져옴.
			System.out.println("유저가 저장한 원본파일이름 : " + mpf.getOriginalFilename() + " uploaded!");
			if (!mpf.isEmpty()) { // 역시 파일이 있다면.
				Serversavedfile = FileService.saveFile(mpf, uploadPath); //파일을 업로드패쓰의 경로에 저장.
				// 서버폴더에 저장하는 파일(바뀐 이름)을 보내서 섬네일파일의 이름을 가져옴.
				// 확장자가 없는 섬네일의 이름임.
				//포토보드의 vo에 저장할 어레이리스트 세팅.
				originalFile.add(mpf.getOriginalFilename());
				savedFile.add(Serversavedfile);
			}
		}
		System.out.println("먹고살기 힘들다 : "+savedFile);
		board.setFreefile_original(originalFile);
		board.setFreefile_saved(savedFile);
		
		int result = dao.write(board);
		int boardNum = 0;
		
		if (result == 1){
			boardNum = dao.getsequence();
			board.setFree_boardnum(boardNum);
			int a = dao.writefile(board);
			if(a != 0){
				return "success";
			}
		}
		return "fail";
	}
	
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public String read(int free_boardnum, Model model, HttpSession session)	{
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		dao.hitup(board);
		ArrayList<HashMap> fileList = dao.FreeFileList(free_boardnum);

		ArrayList<String> oglist = new ArrayList<>();
		ArrayList<String> svlist = new ArrayList<>();
		
		for(HashMap file : fileList){
			System.out.println((String)file.get("FREEFILE_SAVED"));
			oglist.add((String)file.get("FREEFILE_ORIGINAL"));
			svlist.add((String)file.get("FREEFILE_SAVED"));
		}
		
		System.out.println(oglist);
		System.out.println(svlist);
		
		board.setFreefile_original(oglist);
		board.setFreefile_saved(svlist);
		
		List<Rodo_FreeReply> replylist = dao.findreply(free_boardnum);
		
		model.addAttribute("board", board);
		model.addAttribute("id", (String)session.getAttribute("loginId"));
		model.addAttribute("replylist", replylist);
			
		return "freeboard/freeboardread";
	}
	
	@RequestMapping(value = "deletefreeboard", method = RequestMethod.GET)
	public String delete(int free_boardnum, HttpSession session)	{
		ArrayList<HashMap> fileList = dao.FreeFileList(free_boardnum);
		
		ArrayList<String> oglist = new ArrayList<>();
		ArrayList<String> svlist = new ArrayList<>();
		
		for(HashMap file : fileList){
			oglist.add((String)file.get("FREEFILE_ORIGINAL"));
			svlist.add((String)file.get("FREEFILE_SAVED"));
		}
		for(int i = 0; i<oglist.size(); i++){
			FileService.deleteFile(oglist.get(i));
			FileService.deleteFile(svlist.get(i));
		}
		
		List<Rodo_FreeReply> list = dao.findreply(free_boardnum);
		
		for (int i=0; i<list.size(); i++)	{
			if (list.get(i) != null)			{
				dao.deletereply(list.get(i));
			}
		}
		dao.delete(free_boardnum);
		return "redirect:/freeboardlist";
	}
	
	@RequestMapping(value = "updateboard", method = RequestMethod.GET)
	public String update(int free_boardnum, Model model)	{	
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		
		if (board != null)	{
			model.addAttribute("board", board);
			return "freeboard/update";
		}
		return "freeboard/update";
	}
	
	@ResponseBody
	@RequestMapping(value = "updateFree", method = RequestMethod.POST)
	public String updateFree(Rodo_FreeBoard board,
		MultipartHttpServletRequest request, HttpServletResponse response){	
		
		Iterator<String> itr = request.getFileNames();
		
		System.out.println(board.toString() + "asdfadfs"); 
		String OriginalFilename = ""; // 내가 저장할 파일의 이름.(hi.jpg)
		String Serversavedfile = ""; // 서버에 저장할 날짜로 이름이 바뀌어 저장되는
										// 파일.(170329//////////////////)
		
		ArrayList<String> originalFile = new ArrayList<>(); // vo에 담을 OriginalFile
		ArrayList<String> savedFile = new ArrayList<>(); // vo에 담을 SavedFile
		
		while (itr.hasNext()) { //만약 파일이 있다면
			MultipartFile mpf = request.getFile(itr.next()); // 리퀘스트에서 파일을 하나씩 가져옴.
			System.out.println("유저가 저장한 원본파일이름 : " + mpf.getOriginalFilename() + " uploaded!");
			if (!mpf.isEmpty()) { // 역시 파일이 있다면.
				Serversavedfile = FileService.saveFile(mpf, uploadPath); //파일을 업로드패쓰의 경로에 저장.
																		//이때 오늘의 등록날짜시간으로 저장.
				// 서버폴더에 저장하는 파일(바뀐 이름)을 보내서 섬네일파일의 이름을 가져옴.
				//포토보드의 vo에 저장할 어레이리스트 세팅.
				originalFile.add(mpf.getOriginalFilename());
				savedFile.add(Serversavedfile);
			}
		}
		
		board.setFreefile_original(originalFile);
		board.setFreefile_saved(savedFile);
		System.out.println(board.getFreefile_original());
		System.out.println(board.getFreefile_saved());
		
		int i = dao.updateFree(board);
		 
		 if(i!=0){
			 return "success";
		 }
		 return "fail";
	}
	
	@RequestMapping(value = "freeLoad", method = RequestMethod.GET)
	public void freeLoad(String origin, HttpServletResponse response)	{
		try {
			response.setHeader("Content-Disposition", " attachment;filename=" + URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		String OriginfullPath = uploadPath + "/" + origin; // 원래파일

		FileInputStream filein0 = null;
		ServletOutputStream fileout0 = null;
		
		try {
			filein0 = new FileInputStream(OriginfullPath);
			fileout0 = response.getOutputStream();

			// Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein0, fileout0);

			filein0.close();
			fileout0.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "replywrite", method = RequestMethod.POST)
	public List<Rodo_FreeReply> replywrite(Rodo_FreeReply reply, HttpSession session, Model model)	{	
		String id = (String)session.getAttribute("loginId");
		reply.setFreereply_id(id);
		dao.writereply(reply);
		List<Rodo_FreeReply> list = dao.findreply(reply.getFree_boardnum());
		
		/*if (result == 1)
		{
			return "redirect:read?free_boardnum="+reply.getFree_boardnum();
		}
		
		return "freeboard/freeboardread";*/
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "deletereply", method = RequestMethod.GET)
	public List<Rodo_FreeReply> deletereply(Rodo_FreeReply reply, HttpSession session, Model model)	{	
	//	Rodo_FreeReply reply = dao.selectreply(freereply_replynum);
		
		String id = (String)session.getAttribute("loginId");
		reply.setFreereply_id(id);
		
		dao.deletereply(reply);
		
		List<Rodo_FreeReply> list = dao.findreply(reply.getFree_boardnum());
		
	//	return "redirect:/read?free_boardnum="+reply.getFree_boardnum();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "replypage", method = RequestMethod.POST)
	public List<Rodo_FreeReply> replypage(Rodo_FreeReply reply, Model model,
			@RequestParam(value = "page", defaultValue = "1") int page	)	{
		return null;
	}
}