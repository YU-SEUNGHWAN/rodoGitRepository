package project2.scmaster.rodo.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.dao.VideoBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.vo.videoBoard;

@Controller
public class VideoBoardController {

	@Autowired
	VideoBoardDao dao;
	
	@RequestMapping(value="writeVideoForm", method=RequestMethod.GET)
	public String writeVideoForm(){
		
		return "videoboard/videoWrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "getTempVideo", method = RequestMethod.POST)
	public String getTempVideo(MultipartHttpServletRequest request, HttpServletResponse response){
		
		String tempPath = request.getServletContext().getRealPath("/resources/thumbvideo/");
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
        			fullPath = "./resources/thumbvideo/" + FileService.saveFile(mpf, tempPath);
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
	
	@ResponseBody
	@RequestMapping(value="writeVideo", method=RequestMethod.POST)
	public void writeVideo(HttpSession session, MultipartHttpServletRequest request, videoBoard video){
		
		String thumbPath = request.getServletContext().getRealPath("/resources/thumbnail/");
		String thumb = video.getVideo_thumbnail();
		String id = (String)session.getAttribute("loginId");
		String thumbnailFile = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+id+".png";
		byte[] decodedBytes = null;
		
		String videoPath = request.getServletContext().getRealPath("/resources/video/");
		String videoOriginaiFile = null;
		String videoSavedFile = null;
		
		
		String partSeparator = ",";
		if (thumb.contains(partSeparator)) {
		  String encodedImg = thumb.split(partSeparator)[1];
		  decodedBytes = Base64.getDecoder().decode(encodedImg.getBytes(StandardCharsets.UTF_8));
		  
		  ByteArrayInputStream inputStream = new ByteArrayInputStream(decodedBytes);
		  BufferedImage bufferedImage;
			try {
				bufferedImage = ImageIO.read(inputStream);
				ImageIO.write(bufferedImage, "png", new File(thumbPath+thumbnailFile));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		Iterator<String> itr =  request.getFileNames();
		
		if (itr.hasNext()){
            MultipartFile mpf = request.getFile(itr.next());
            videoOriginaiFile = mpf.getOriginalFilename();
            
            try
            {
                System.out.println("file length : " + mpf.getBytes().length);
                System.out.println("file name : " + mpf.getOriginalFilename());
                
        		if (!mpf.isEmpty())
        		{
        			videoSavedFile = "./resources/thumbvideo/" + FileService.saveFile(mpf, videoPath);
        		}
            }
            catch (IOException e){
                e.printStackTrace();
            }
	    }
		
		
		
		video.setVideo_id(id);
		video.setVideo_thumbnail("./resources/thumbnail/"+thumbnailFile);
		video.setVideo_originalfile(videoOriginaiFile);
		video.setVideo_savedfile(videoSavedFile);
		
		dao.write(video);
		
	}
	
}
