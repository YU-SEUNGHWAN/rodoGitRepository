package project2.scmaster.rodo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import project2.scmaster.rodo.dao.MemberDao;
import project2.scmaster.rodo.util.SendInfo;
import project2.scmaster.rodo.util.SendMail;
import project2.scmaster.rodo.vo.Member;

@Controller
public class MailController
{
	@Autowired
	MemberDao dao;
	
	/**
	    * 인증번호 보내기 
	    * @return
	    */
	   @ResponseBody
	   @RequestMapping(value="emailcheck", method=RequestMethod.POST)
	   public void emailcheck(String user, HttpSession session)
	   {
		  System.out.println(user);
		  
	      SendMail mail = new SendMail("", null, null);
	      
	      int code = mail.test(user);
	      //logger.debug("{}",checkCode);
	      
	  //  session.setAttribute("code", code);
	      setNum(code);
	      
	      System.out.println("메일 전송완료.");
	   }
	   
	   @ResponseBody
	   @RequestMapping(value = "sendid", method = RequestMethod.POST)
	   public void sendid(String user, String id)	// 순서대로 email, id 임
	   {
		   SendInfo info = new SendInfo("", null, null);
			
		   info.sendingid(user, id);
			
		   System.out.println("이메일로 아이디 전송 완료");
	   }
	   
	   @ResponseBody
	   @RequestMapping(value = "sendpw", method = RequestMethod.POST)
	   public int sendpw(Member member)	// 순서대로 email, id 임
	   {   
		   System.out.println(member.toString());
		   
		   SendInfo info = new SendInfo("", null, null);
		   
		   String user = member.getEmail();
		   String id = member.getId();
		   
		   int pw = info.sendingpw(user, id);
		   
		   System.out.println("이메일로 임시암호 전송 완료");
		   
		   return pw;
	   }
	   
	static int num;

	static public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
}