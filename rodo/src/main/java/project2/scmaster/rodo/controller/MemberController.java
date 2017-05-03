package project2.scmaster.rodo.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import project2.scmaster.rodo.dao.MemberDao;
import project2.scmaster.rodo.dao.Rodo_FreeBoardDao;
import project2.scmaster.rodo.dao.Rodo_GpsBoardDao;
import project2.scmaster.rodo.dao.Rodo_PhotoBoardDAO;
import project2.scmaster.rodo.dao.VideoBoardDao;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.vo.Member;
import project2.scmaster.rodo.vo.Rodo_FreeBoard;
import project2.scmaster.rodo.vo.Rodo_GpsBoard;
import project2.scmaster.rodo.vo.Rodo_PhotoBoard;
import project2.scmaster.rodo.vo.videoBoard;

@Controller
@SessionAttributes({"member", "joincomplete", "loginErr"})
public class MemberController 
{	
	@Autowired
	MemberDao dao;
	
	@Autowired
	Rodo_FreeBoardDao free_dao;
	
	@Autowired
	Rodo_PhotoBoardDAO photo_dao;
	
	@Autowired
	VideoBoardDao video_dao;
	
	@Autowired
	Rodo_GpsBoardDao gps_dao;
	
	int countPerPage = 5;		// 페이지 당 글 수
	int pagePerGroup = 5;		// 페이지 이동 그룹 당 표시할 페이지 수
	
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insert()
	{
		return "member/insert";
	}
	
	@RequestMapping(value = "mailcheckbutton", method = RequestMethod.GET)
	public String insert2()
	{
		return "member/mailcheckbutton";
	}
	
	@ResponseBody
	@RequestMapping(value = "checkidajax", method = RequestMethod.POST)
	public Member checkidajax(String id)
	{
		Member member = dao.selectOne(id);
		
		return member;
	}
	
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String join(Member member, Model model)
	{
		System.out.println(member.toString());
		
		int result = dao.insert(member);
		String joincomplete = null;
		
		if (result != 1)
		{
			model.addAttribute("error", "가입 실패");
			return "member/insert";
		}
		
		else
		{
			joincomplete = "complete";
			model.addAttribute("joincomplete", joincomplete);
			return "redirect:/";
		}
	}
	
	/*@RequestMapping(value = "joincomplete", method = RequestMethod.GET)
	public String joincomplete(Model model, @ModelAttribute("member") Member member,
			SessionStatus sessionStatus)
	{
		model.addAttribute("id", member.getId());
		sessionStatus.setComplete();
		
		return "member/joincomplete";
	}*/
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login2(String loginid, String loginpassword, Model model, HttpSession session, SessionStatus sessionStatus)
	{
		/*String id = loginid;
		String password = loginpassword;*/
		
		sessionStatus.setComplete();
		
		Member member = dao.selectOne(loginid);
		
		String error = null;
		
		if (member == null)
		{
			error = "error";
			model.addAttribute("loginErr", error);
			return "index";
		}
		
		else
		{
			if (member.getPassword().equals(loginpassword))
			{
				session.setAttribute("loginId", member.getId());
				model.addAttribute("member", member);
				
				return "redirect:index";
			}
			
			else
			{
				error = "error";
				model.addAttribute("loginErr", error);
				return "index";
			}
		}
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session)
	{
		session.invalidate();
		
		return "redirect:index";
	}
	
	@RequestMapping(value = "find", method = RequestMethod.GET)
	public String find()
	{
		return "member/find";
	}
	
	@ResponseBody
	@RequestMapping(value = "findid", method = RequestMethod.POST)
	public String findid(String email)
	{
		String id = dao.findid(email);
		
		return id;
	}
	
	@RequestMapping(value = "checkupdate", method = RequestMethod.GET)
	public String checkupdate()
	{
		return "member/checkupdate";
	}
	
	@ResponseBody
	@RequestMapping(value = "beforeupdate", method = RequestMethod.POST)
	public String beforeupdate(String password, HttpSession session)
	{
		String id = (String)session.getAttribute("loginId");
		
		Member member = dao.selectOne(id);
		
		return member.getPassword();
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update2(HttpSession session, Model model)
	{	
		String id = (String)session.getAttribute("loginId");
		
		Member member = dao.selectOne(id);
		model.addAttribute("member", member);

		return "member/update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, Member member)
	{
		int result = dao.update(member);
		
		if (result != 1)
		{
			return "member/update";
		}
		
		model.addAttribute("rada","rada");
		
		return "member/update";
	}
	
	@ResponseBody
	@RequestMapping(value = "findpw", method = RequestMethod.POST)
	public Member findpw(String id)
	{
		Member member = dao.selectOne(id);
		
		if (member != null)
		{
			System.out.println(member.toString());
		}
		
		return member;
	}
	
	@ResponseBody
	@RequestMapping(value = "checknum", method = RequestMethod.POST)
	public int checknum()
	{
		return MailController.getNum();
	}
	
	@ResponseBody
	@RequestMapping(value = "emailcheck2", method = RequestMethod.POST)
	public String emailcheck(String email)
	{
		String foundemail = dao.emailcheck(email);
		
		return foundemail;
	}
	
	@ResponseBody
	@RequestMapping(value = "updatepw", method = RequestMethod.POST)
	public String updatepw(Member member)
	{
		System.out.println(member.toString());
		
		int result = dao.updatepw(member);
		
		if (result != 1)
		{
			return null;
		}
		
		return "well done.";
	}
	
	@RequestMapping(value = "mypage", method = RequestMethod.GET)
	public String mypage(HttpSession session, Model model)
	{
		String id = (String)session.getAttribute("loginId");
		
		Member member = dao.selectOne(id);
		model.addAttribute("member", member);
		
		return "member/mypage";
	}
	
	@ResponseBody
	@RequestMapping(value = "loadmylist", method = RequestMethod.POST)
	public HashMap<?, ?> loadmylist(HttpSession session, Model model,
			@RequestParam(value = "page", defaultValue = "1") int page)
	{
		String id = (String)session.getAttribute("loginId");
		Member member = dao.selectOne(id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("뜨는거 맞냐?");
		
		int freecount = free_dao.writefreeboardcount(id);
		
		if (freecount == 0)
		{
			freecount = 1;
		}
		
		PageNavigator freenavi = new PageNavigator(countPerPage, pagePerGroup, page, freecount);
		List<Rodo_FreeBoard> freelist = free_dao.myfreelist(freenavi.getStartRecord(), freenavi.getCountPerPage(), id);
		
		
		int photocount = photo_dao.writephotoboardcount(id);
		
		if (photocount == 0)
		{
			photocount = 1;
		}
		
		PageNavigator photonavi = new PageNavigator(countPerPage, pagePerGroup, page, photocount);
		List<Rodo_PhotoBoard> photolist = photo_dao.myphotolist(photonavi.getStartRecord(), photonavi.getCountPerPage(), id);
		
		
		int videocount = video_dao.writevideoboardcount(id);
		
		if (videocount == 0)
		{
			videocount = 1;
		}
		
		PageNavigator videonavi = new PageNavigator(countPerPage, pagePerGroup, page, videocount);
		List<videoBoard> videolist = video_dao.myvideolist(videonavi.getStartRecord(), videonavi.getCountPerPage(), id);
		
		
		int gpscount = gps_dao.writegpsboardcount(id);
		
		if (gpscount == 0)
		{
			gpscount = 1;
		}
		
		PageNavigator gpsnavi = new PageNavigator(countPerPage, pagePerGroup, page, gpscount);
		List<Rodo_GpsBoard> gpslist = gps_dao.mygpslist(gpsnavi.getStartRecord(), gpsnavi.getCountPerPage(), id);
				
		map.put("member", member);
		
		map.put("freecount", freecount);
		map.put("freenavi", freenavi);
		map.put("freelist", freelist);
		
		map.put("photocount", photocount);
		map.put("photonavi", photonavi);
		map.put("photolist", photolist);
		
		map.put("videocount", videocount);
		map.put("videonavi", videonavi);
		map.put("videolist", videolist);
		
		map.put("gpscount", gpscount);
		map.put("gpsnavi", gpsnavi);
		map.put("gpslist", gpslist);
		
		return map;
	}
}