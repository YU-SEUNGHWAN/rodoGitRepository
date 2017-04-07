package project2.scmaster.rodo.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import project2.scmaster.rodo.dao.MessageDao;
import project2.scmaster.rodo.vo.Message;

@Controller
public class MessageController {

	@Autowired
	public MessageDao dao;
	
	@RequestMapping(value="messageList", method=RequestMethod.GET)
	public String messageList(Model model, HttpSession session){
	
		String id = (String)session.getAttribute("loginId");
		ArrayList<Message> received = dao.receivedMessage(id);
		System.out.println(received);
		model.addAttribute("received", received);
		
		return "Message/messageList";
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxReceived", method=RequestMethod.GET)
	public ArrayList<Message> ajaxReceived(HttpSession session){
		
		String id = (String)session.getAttribute("loginId");
		ArrayList<Message> received = dao.receivedMessage(id);
		
		return received;
	}

	@ResponseBody
	@RequestMapping(value="ajaxSent", method=RequestMethod.GET)
	public ArrayList<Message> ajaxSent(HttpSession session){
		
		String id = (String)session.getAttribute("loginId");
		ArrayList<Message> sent = dao.sentMessage(id);
		
		return sent;
	}

	@RequestMapping(value="writeMessage", method=RequestMethod.GET)
	public String writeMessageForm(){
		
		return "Message/writeMessage";
	}
	
	@ResponseBody
	@RequestMapping(value="writeMessage", method=RequestMethod.POST)
	public Message writeMessage(HttpSession session, Message message){
		
		String sender = (String)session.getAttribute("loginId");
		message.setSender(sender);		
		dao.writeMessage(message);
		
		return message;
	}
	
	@RequestMapping(value="readMessage", method=RequestMethod.GET)
	public String readMessage(Model model, int messagenum){

		Message message = dao.readMessage(messagenum);
		model.addAttribute("message", message);
		
		return "Message/readMessage";
	}
	
}
