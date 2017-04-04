package project2.scmaster.rodo.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import project2.scmaster.rodo.dao.Rodo_FreeBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.vo.Rodo_FreeBoard;


@Controller
public class FreeBoardController 
{
	@Autowired
	Rodo_FreeBoardDao dao;
	
	final String uploadPath = "/boardfile";
	
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
	public String freeboardwrite2(Rodo_FreeBoard board, 
			MultipartFile upload, HttpSession session)
	{
		String free_id = (String)session.getAttribute("id");
		board.setFree_id(free_id);
		
		int result = dao.write(board);
		
		System.out.println(board.toString());
		int result2 = 0;
		
		if (!upload.isEmpty()) // upload != null 로 하면 안된다. 얘는 반드시 이렇게 써야 함
		{
			String savedfile = FileService.saveFile(upload, uploadPath);
			board.setFreefile_original(upload.getOriginalFilename());
			board.setFreefile_saved(savedfile);
			
			int seq = dao.getsequence();
			board.setFree_boardnum(seq);
			
			System.out.println(seq+"kkkkkkkkkkkkk");
			System.out.println(board.toString());
			
			result2 = dao.writefile(board);
		}
		
		if (result == 1)
		{
			return "redirect:/freeboardlist";
		}
		
		else if (result == 1 && result2 == 1)
		{
			return "redirect:/freeboardlist";
		}

		return "freeboard/freeboardwrite";
	}
	
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public String read(int free_boardnum, Model model, HttpSession session)
	{
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		
		if (board == null)
		{
			return "redirect:freeboardlist";
		}
		
		model.addAttribute("board", board);
		model.addAttribute("id", (String)session.getAttribute("id"));
		
		System.out.println(board.toString());
		
		return "freeboard/freeboardread";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(int free_boardnum, HttpSession session)
	{
		Rodo_FreeBoard board = new Rodo_FreeBoard();
		
		board.setFree_boardnum(free_boardnum);
		board.setFree_id((String)session.getAttribute("id"));
		
		dao.delete(board);
		
		return "redirect:/freeboardlist";
	}
	
	@RequestMapping(value = "updateboard", method = RequestMethod.GET)
	public String update(int free_boardnum, Model model)
	{	
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		model.addAttribute("board", board);
	
		return "freeboard/update";
	}
	
	@RequestMapping(value = "updateboard", method = RequestMethod.POST)
	public String update2(Rodo_FreeBoard board)
	{	
		int result = dao.update(board);
		
		if (result != 1)
		{
			return "freeboard/update";
		}
		
		return "redirect:/freeboardlist";
	}
	
	
	@RequestMapping(value = "download", method = RequestMethod.GET)
	public String download(int free_boardnum, HttpServletResponse response)
	{
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		
		try 
		{
			response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(board.getFreefile_original(), "UTF-8"));
		}
		
		catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 저장된 파일 경로
		String fullPath = uploadPath + "/" + board.getFreefile_saved();
		
		// 서버의 파일을 읽을 입력 스트림
		// 클라이언트에게 전달할 출력 스트림
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		
		try 
		{
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			// Spring 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
		} 
		
		catch (IOException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
}