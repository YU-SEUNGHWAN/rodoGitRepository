package project2.scmaster.rodo.controller;

import java.io.FileInputStream;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import project2.scmaster.rodo.dao.Rodo_FreeBoardDao;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_FreeReply;


@Controller
public class FreeBoardController 
{
	final int countPerPage = 10;		// 페이지 당 글 수
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
	public String freeboardwrite()
	{
		return "freeboard/freeboardwrite";
	}
	
	@RequestMapping(value = "freeboardwrite", method = RequestMethod.POST)
	public String freeboardwrite2(Rodo_FreeBoard board, 
			MultipartFile upload, HttpSession session)
	{
		String id = (String)session.getAttribute("id");
		board.setFree_id(id);
		
		int result = dao.write(board);
		
		int result2 = 0;
		
		/*if (!upload.isEmpty()) // upload != null 로 하면 안된다. 얘는 반드시 이렇게 써야 함
		{
			String savedfile = FileService.saveFile(upload, uploadPath);
			board.setFreefile_original(upload.getOriginalFilename());
			board.setFreefile_saved(savedfile);
			
			int seq = dao.getsequence();
			board.setFree_boardnum(seq);
			
			System.out.println(seq+"kkkkkkkkkkkkk");
			System.out.println(board.toString());
			
			result2 = dao.writefile(board);
		}*/
		
		if (result == 1)
		{
			return "redirect:/freeboardlist";
		}
		
		/*else if (result == 1 && result2 == 1)
		{
			return "redirect:/freeboardlist";
		}*/

		return "freeboard/freeboardwrite";
	}
	
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public String read(int free_boardnum, Model model, HttpSession session)
	{
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		Rodo_FreeBoard board2 = dao.selectnofile(free_boardnum);
		
		if (board == null && board2 == null)
		{	
			return "redirect:freeboardlist";
		}
		
		else if (board != null)
		{
			List<Rodo_FreeReply> replylist = dao.findreply(free_boardnum);
			
			model.addAttribute("board", board);
			model.addAttribute("id", (String)session.getAttribute("id"));
			model.addAttribute("replylist", replylist);
			
			return "freeboard/freeboardread";
		}
		
		else if (board == null && board2 != null)
		{
			List<Rodo_FreeReply> replylist = dao.findreply(free_boardnum);
			
			model.addAttribute("board", board2);
			model.addAttribute("id", (String)session.getAttribute("id"));
			model.addAttribute("replylist", replylist);
			
			return "freeboard/freeboardread";
		}
		
		return "freeboard/freeboardread";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(int free_boardnum, HttpSession session)
	{
		Rodo_FreeBoard board = new Rodo_FreeBoard();
		
		board.setFree_boardnum(free_boardnum);
		board.setFree_id((String)session.getAttribute("id"));
		
		List<Rodo_FreeReply> list = dao.findreply(free_boardnum);
		
		for (int i=0; i<list.size(); i++)
		{
			if (list.get(i) != null)
			{
				dao.deletereply(list.get(i));
			}
		}
		
		dao.delete(board);
		
		return "redirect:/freeboardlist";
	}
	
	@RequestMapping(value = "updateboard", method = RequestMethod.GET)
	public String update(int free_boardnum, Model model)
	{	
		Rodo_FreeBoard board = dao.selectOne(free_boardnum);
		Rodo_FreeBoard board2 = dao.selectnofile(free_boardnum);
		
		if (board != null)
		{
			model.addAttribute("board", board);
			
			return "freeboard/update";
		}
		
		else if (board == null && board2 != null)
		{
			model.addAttribute("board", board2);
			
			return "freeboard/update";
		}
		
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
		
		/*try 
		{
			response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(board.getFreefile_original(), "UTF-8"));
		}
		
		catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
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
	
	@RequestMapping(value = "replywrite", method = RequestMethod.POST)
	public String replywrite(Rodo_FreeReply reply, HttpSession session, Model model)
	{	
		String id = (String)session.getAttribute("id");
		reply.setFreereply_id(id);
		
		int result = dao.writereply(reply);
		
		if (result == 1)
		{
			return "redirect:read?free_boardnum="+reply.getFree_boardnum();
		}
		
		return "freeboard/freeboardread";
	}
	
	@RequestMapping(value = "deletereply", method = RequestMethod.GET)
	public String deletereply(Rodo_FreeReply reply, HttpSession session, Model model)
	{	
	//	Rodo_FreeReply reply = dao.selectreply(freereply_replynum);
		
		System.out.println(reply.toString());
		
		dao.deletereply(reply);
		
		return "redirect:/read?free_boardnum="+reply.getFree_boardnum();
	}
}