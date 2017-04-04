package project2.scmaster.rodo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import project2.scmaster.rodo.dao.MemberDao;
import project2.scmaster.rodo.util.Parsing;
import project2.scmaster.rodo.vo.GPX;
import project2.scmaster.rodo.vo.Member;

@Controller
@SessionAttributes({"member"})
public class MemberController 
{	
	@Autowired
	MemberDao dao;
	
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insert()
	{
		return "member/insert";
	}
	
	@RequestMapping(value = "idcheckbutton", method = RequestMethod.GET)
	public String insert2()
	{
		return "member/idcheckbutton";
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
		model.addAttribute("member", member);
		
		int result = dao.insert(member);
		
		if (result != 1)
		{
			model.addAttribute("error", "가입 실패");
			return "member/insert";
		}
		
		return "redirect:/joincomplete";
	}
	
	@RequestMapping(value = "joincomplete", method = RequestMethod.GET)
	public String joincomplete(Model model, @ModelAttribute("member") Member member,
			SessionStatus sessionStatus)
	{
		model.addAttribute("id", member.getId());
		sessionStatus.setComplete();
		
		return "member/joincomplete";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login()
	{
		return "member/login";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login2(String id, String password, Model model, HttpSession session)
	{
		Member member = dao.selectOne(id);
		
		if (member == null)
		{
			model.addAttribute("loginErr", "로그인 정보가 틀렸습니다.");
			return "member/login";
		}
		
		else
		{
			if (member.getPassword().equals(password))
			{
				session.setAttribute("loginId", member.getId());
				session.setAttribute("loginName", member.getName());
				
				return "redirect:index";
			}
			
			else
			{
				model.addAttribute("loginErr", "로그인 정보가 틀렸습니다.");
				return "member/login";
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
		String id = (String)session.getAttribute("id");
		
		Member member = dao.selectOne(id);
		
		return member.getPassword();
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update2(HttpSession session, Model model)
	{	
		String id = (String)session.getAttribute("id");
		
		Member member = dao.selectOne(id);
		model.addAttribute("member", member);

		return "member/update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Member member)
	{
		int result = dao.update(member);
		
		if (result != 1)
		{
			return "member/update";
		}
		
		return "redirect:/";
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
}