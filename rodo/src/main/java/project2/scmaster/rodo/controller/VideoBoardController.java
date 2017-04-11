package project2.scmaster.rodo.controller;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.util.FileService;

@Controller
public class VideoBoardController {

	@RequestMapping(value="writeVideoForm", method=RequestMethod.GET)
	public String writeVideoForm(){
		
		return "videoboard/videoWrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "getTempVideo", method = RequestMethod.POST)
	public String getTempVideo(MultipartHttpServletRequest request, HttpServletResponse response){
		
		String tempPath = request.getServletContext().getRealPath("/resources/video/");
		String fullPath = null;
		
		
        Iterator<String> itr =  request.getFileNames();
        
        if (itr.hasNext())
        {
            MultipartFile mpf = request.getFile(itr.next());
            System.out.println(mpf.getOriginalFilename() +" uploaded!");
            try
            {
                System.out.println("file length : " + mpf.getBytes().length);
                System.out.println("file name : " + mpf.getOriginalFilename());
                
        		if (!mpf.isEmpty())
        		{
        			System.out.println(tempPath);
        			fullPath = "./resources/video/" + FileService.saveFile(mpf, tempPath);
        			System.out.println(fullPath);
        		}
            }
            catch (IOException e){
                e.printStackTrace();
            }
            return fullPath;
        }
        else
        {
            return fullPath;
        }
		
	}
	
}
