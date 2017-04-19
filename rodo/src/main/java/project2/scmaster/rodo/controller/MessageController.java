package project2.scmaster.rodo.controller;

import java.util.ArrayList;
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

import project2.scmaster.rodo.dao.MessageDao;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.vo.Message;

@Controller
public class MessageController 
{	
	final int countPerPage = 10;		// 페이지 당 글 수
	final int pagePerGroup = 5;		// 페이지 이동 그룹 당 표시할 페이지 수
	
	@Autowired
	public MessageDao dao;
	
	@RequestMapping(value="messageList", method=RequestMethod.GET)
	public String messageList(Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{
		
		String id = (String)session.getAttribute("loginId");
		
		int total = dao.receivelistsize(id);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		ArrayList<Message> received = dao.receivedMessage(navi.getStartRecord(), navi.getCountPerPage(), id);
		
		
		model.addAttribute("received", received);
		model.addAttribute("navi", navi);
		
		
		return "Message/messageList";
	}
	
	/*@ResponseBody
	@RequestMapping(value = "sendmessagelist", method = RequestMethod.GET)
	public HashMap<String, Object> sendmessagelist(Message message, HttpSession session, Model model,
			@RequestParam(value="page",defaultValue="1")   int page)
	{
	      String id = (String)session.getAttribute("loginId");
	      message.setSender(id);
	      
	      int count = dao.sendlistsize(id);
	      
	      PageNavigator navi= new PageNavigator(countPerPage, pagePerGroup, page, count);
	      
	      List<Message> list = dao.sendlist(navi.getStartRecord(), navi.getCountPerPage(), message.getSender());
	     
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      map.put("list", list);
	     
	      map.put("navi", navi);
	     
	      System.out.println(map+"30");
	      model.addAttribute("navi", navi);
	    
	      return map;
	   }*/
	
	/*@RequestMapping(value = "receivelist", method=RequestMethod.GET)
	public String receivelist(Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{
		String id = (String)session.getAttribute("loginId");
		
		int total = dao.receivelistsize(id);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		ArrayList<Message> list = dao.receivelist(navi.getStartRecord(), navi.getCountPerPage(), id);
		
		model.addAttribute("received", list);
		model.addAttribute("navi", navi);
		
		return "Message/messageList";
	}*/
	
	@RequestMapping(value = "sendlist", method=RequestMethod.GET)
	public String sendlist(Model model, HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{
		
		String id = (String)session.getAttribute("loginId");
		
		int total = dao.sendlistsize(id);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		ArrayList<Message> list = dao.sendlist(navi.getStartRecord(), navi.getCountPerPage(), id);
		
		model.addAttribute("sent", list);
		model.addAttribute("navi", navi);
		
		return "Message/sendmessagelist";
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxReceived", method=RequestMethod.GET)
	public ArrayList<Message> ajaxReceived(HttpSession session, Model model,
			@RequestParam(value = "page", defaultValue = "1") int page
			)
	{	
		String id = (String)session.getAttribute("loginId");
		
		int total = dao.receivelistsize(id);
		
		PageNavigator navi2 = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		ArrayList<Message> received = dao.receivedMessage(navi2.getStartRecord(), navi2.getCountPerPage(), id);
		
		model.addAttribute("navi2", navi2);
		
		return received;
	}

	@ResponseBody
	@RequestMapping(value="ajaxSent", method=RequestMethod.GET)
	public ArrayList<Message> ajaxSent(HttpSession session)
	{
		String id = (String)session.getAttribute("loginId");
		ArrayList<Message> sent = dao.sentMessage(id);
		
		return sent;
	}

	@RequestMapping(value="writeMessage", method=RequestMethod.GET)
	public String writeMessageForm()
	{	
		return "Message/writeMessage";
	}
	
	@ResponseBody
	@RequestMapping(value="writeMessage", method=RequestMethod.POST)
	public Message writeMessage(HttpSession session, Message message)
	{	
		String sender = (String)session.getAttribute("loginId");
		message.setSender(sender);
		
		System.out.println(message.toString());
		dao.writeMessage(message);
		
		dao.writereceiveMessage(message);
		
		return message;
	}
	
	@RequestMapping(value = "henjiMessage", method=RequestMethod.GET)
	public String henjiMessage(String sender, Model model)
	{
		model.addAttribute("sender", sender);
		
		return "Message/henjiMessage";
	}
	
	@RequestMapping(value="readreceivedMessage", method=RequestMethod.GET)
	public String readreceivedMessage(Model model, int messagenum)
	{
		System.out.println(messagenum);
		
		Message receivemessage = dao.receivedreadMessage(messagenum);

		model.addAttribute("receivemessage", receivemessage);
		System.out.println(receivemessage.toString());
		
		return "Message/readMessage";
	}
	
	@RequestMapping(value="readsentMessage", method=RequestMethod.GET)
	public String readsendtMessage(Model model, int messagenum)
	{
		System.out.println(messagenum);
		
		Message sendmessage = dao.sendreadMessage(messagenum);
	
		model.addAttribute("sendmessage", sendmessage);
		System.out.println(sendmessage.toString());
		
		return "Message/readMessage";
	}
	
	@RequestMapping(value="deletereceiveMessage", method=RequestMethod.GET)
	public String deletereceiveMessage(Message message)
	{
		System.out.println(message.toString());
		
		dao.deletereceiveMessage(message);
		
		return "redirect:/messageList";
	}
	
	@RequestMapping(value="deletesendMessage", method=RequestMethod.GET)
	public String deletesendMessage(Message message)
	{
		System.out.println(message.toString());
		
		dao.deletesendMessage(message);
		
		return "redirect:/sendlist";
	}
	
	@RequestMapping(value="alldeleteReceive", method=RequestMethod.GET)
	public String alldeleteReceive( HttpSession session)
	{
		String receiver = (String)session.getAttribute("loginId");
		
		dao.alldeleteReceive(receiver);

		return "redirect:/messageList";
	}
	
	@RequestMapping(value="alldeleteSend", method=RequestMethod.GET)
	public String alldeleteSend(HttpSession session)
	{
		String sender = (String)session.getAttribute("loginId");
		
		dao.alldeleteSend(sender);

		return "redirect:/sendlist";
	}
}