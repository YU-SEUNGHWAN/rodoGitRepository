package project2.scmaster.rodo.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.dao.VideoBoardDao;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.util.PageNavigator;
import project2.scmaster.rodo.vo.Rodo_VideoReply;
import project2.scmaster.rodo.vo.videoBoard;

@Controller
public class VideoBoardController {
	final String videouploadPath = "/videoboardfile"; // 파일 업로드 경로
	final String videotnUploadPath = "/videothumbnail";// 섬네일 업로드 경로
	final String videoviUploadPath = "/videovi";// 섬네일 업로드 경로
	final int countPerPage = 6;		// 페이지 당 글 수
	final int pagePerGroup = 5;		// 페이지 이동 그룹 당 표시할 페이지 수
	
	@Autowired
	VideoBoardDao dao;
	
	@RequestMapping(value="videoBoard", method=RequestMethod.GET)
	public String videoBoard(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText
			)
	{
		ArrayList<videoBoard> video_board = new ArrayList<>();
		
		int total = dao.listsize(searchText); 
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		video_board = dao.Videolist(navi.getStartRecord(), navi.getCountPerPage(), searchText);
		model.addAttribute("searchText", searchText);
		model.addAttribute("videoList", video_board);
		model.addAttribute("navi", navi);
		return "videoBoard";
	}

	@RequestMapping(value = "writeVideoForm", method = RequestMethod.GET)
	public String writeVideoForm() {
		return "videoboard/videoWrite";
	}

	@ResponseBody
	@RequestMapping(value = "getTempVideo", method = RequestMethod.POST)
	public String getTempVideo(MultipartHttpServletRequest request, HttpServletResponse response) {

		String tempPath = request.getServletContext().getRealPath("/resources/thumbvideo/");
		String fullPath = null;

		Iterator<String> itr = request.getFileNames();

		if (itr.hasNext()) {
			MultipartFile mpf = request.getFile(itr.next());
			System.out.println(mpf.getOriginalFilename() + " uploaded!");
			try {
				System.out.println("file length : " + mpf.getBytes().length);
				System.out.println("file name : " + mpf.getOriginalFilename());

				if (!mpf.isEmpty()) {
					fullPath = "./resources/thumbvideo/" + FileService.saveFile(mpf, tempPath);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return fullPath;
		} else {
			return fullPath;
		}
	}

	@ResponseBody
	@RequestMapping(value = "writeVideo", method = RequestMethod.POST)
	public void writeVideo(HttpSession session, MultipartHttpServletRequest request, videoBoard video) {
		
		String thumbPath = request.getServletContext().getRealPath("/resources/thumbnail/");
		String thumb = video.getVideo_thumbnail();
		String id = (String) session.getAttribute("loginId");
		String thumbnailFile = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + id + ".png";
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
				
				File path = new File(thumbPath);
				if (!path.isDirectory()) {
					path.mkdirs();
				}
				bufferedImage = ImageIO.read(inputStream);
				ImageIO.write(bufferedImage, "png", new File(thumbPath + thumbnailFile));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		Iterator<String> itr = request.getFileNames();

		if (itr.hasNext()) {
			MultipartFile mpf = request.getFile(itr.next());
			videoOriginaiFile = mpf.getOriginalFilename();
			try {
				System.out.println("file length : " + mpf.getBytes().length);
				System.out.println("file name : " + mpf.getOriginalFilename());

				if (!mpf.isEmpty()) {
					videoSavedFile = "./resources/video/" + FileService.saveFile(mpf, videoPath);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		video.setVideo_id(id);
		video.setVideo_thumbnail("./resources/thumbnail/" + thumbnailFile);
		video.setVideo_originalfile(videoOriginaiFile);
		video.setVideo_savedfile(videoSavedFile);
		dao.write(video);
	}

	@RequestMapping(value = "downloadVideo", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin, String tn) {
		try {
			System.out.println("세이브파일 : " + origin);
			System.out.println("섬네일파일 : " + tn);
			response.setHeader("Content-Disposition", " attachment;filename=" + URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		FileInputStream filein0 = null;
		ServletOutputStream fileout0 = null;

		try {
			filein0 = new FileInputStream(tn);
			fileout0 = response.getOutputStream();

			// Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein0, fileout0);

			filein0.close();
			fileout0.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "readVideo", method = RequestMethod.GET)
	public String readVideo(Model model, int video_boardnum){
		
		System.out.println(video_boardnum);
		
		videoBoard videoBoard = dao.readVideo(video_boardnum);
		List<Rodo_VideoReply> list = dao.findreply(video_boardnum);
		
		model.addAttribute("videoBoard", videoBoard);
		model.addAttribute("replylist", list);
		
		return "videoboard/readVideo";
		
	}

	@RequestMapping(value = "deleteVideo", method = RequestMethod.GET)
	public String deleteVideo(int video_boardnum) {

		videoBoard videoBoard = dao.readVideo(video_boardnum);
		FileService.deleteFile(videoBoard.getVideo_originalfile());

		dao.deleteVideo(videoBoard.getVideo_boardnum());
		return "redirect:videoBoard";
		
	}

	@RequestMapping(value = "updateVideo", method = RequestMethod.GET)
	public String updateVideo(int video_boardnum, Model model) {
		
		videoBoard videoBoard = dao.readVideo(video_boardnum);
		model.addAttribute("videoBoard", videoBoard);
		return "videoboard/updateVideo";
		
	}

	@ResponseBody
	@RequestMapping(value = "updateVideo", method = RequestMethod.POST)
	public void updateVideo(HttpSession session, MultipartHttpServletRequest request, videoBoard video) {
		
		
		
		System.out.println("넘어온비디오값 : "+video.toString());
		if (video.getVideo_thumbnail() != null) {
			String thumbPath = request.getServletContext().getRealPath("/resources/thumbnail/");
			String thumb = video.getVideo_thumbnail();
			String id = (String) session.getAttribute("loginId");
			video.setVideo_id(id);
			String thumbnailFile = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + id + ".png";
			byte[] decodedBytes = null;
			String videoPath = request.getServletContext().getRealPath("/resources/video/");
			String videoOriginaiFile = null;
			String videoSavedFile = null;

			System.out.println(thumb);

			String partSeparator = ",";
			
			if (thumb.contains(partSeparator)) {
				String encodedImg = thumb.split(partSeparator)[1];
				decodedBytes = Base64.getDecoder().decode(encodedImg.getBytes(StandardCharsets.UTF_8));
				
				ByteArrayInputStream inputStream = new ByteArrayInputStream(decodedBytes);
				BufferedImage bufferedImage;
				try {
					
					File path = new File(thumbPath);
					if (!path.isDirectory()) {
						path.mkdirs();
					}
					bufferedImage = ImageIO.read(inputStream);
					ImageIO.write(bufferedImage, "png", new File(thumbPath + thumbnailFile));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			Iterator<String> itr = request.getFileNames();

			if (itr.hasNext()) {
				MultipartFile mpf = request.getFile(itr.next());
				videoOriginaiFile = mpf.getOriginalFilename();
				try {
					System.out.println("file length : " + mpf.getBytes().length);
					System.out.println("file name : " + mpf.getOriginalFilename());

					if (!mpf.isEmpty()) {
						videoSavedFile = "./resources/video/" + FileService.saveFile(mpf, videoPath);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			//전달된 전체 경로로 File객체 생성
			File delFile = new File("./resources/thumbnail/" + thumbnailFile);
			
			//해당 파일이 존재하면 삭제
			if (delFile.isFile()) {
				delFile.delete();
			}
			
			video.setVideo_id(id);
			video.setVideo_thumbnail("./resources/thumbnail/" + thumbnailFile);
			video.setVideo_originalfile(videoOriginaiFile);
			video.setVideo_savedfile(videoSavedFile);
		}
		else{
			videoBoard vb= dao.readVideo(video.getVideo_boardnum());
			System.out.println("파일안저장했을때 : "+vb.toString());
			video.setVideo_thumbnail(vb.getVideo_thumbnail());
			video.setVideo_originalfile(vb.getVideo_originalfile());
			video.setVideo_savedfile(vb.getVideo_savedfile());
		}
		System.out.println("다오로 넘어갈 비디오 정보 : " + video.toString());
		dao.updateVideo(video);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "writevideoreply", method = RequestMethod.POST)
	public List<Rodo_VideoReply> writevideoreply(Rodo_VideoReply reply, Model model, HttpSession session)
	{	
		String id = (String)session.getAttribute("loginId");
		reply.setVideoreply_id(id);
		
		System.out.println("==================================");
		System.out.println(reply.toString());
		
		dao.writevideoreply(reply);
		
		List<Rodo_VideoReply> list = dao.findreply(reply.getVideo_boardnum());
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "deletevideoreply", method = RequestMethod.POST)
	public List<Rodo_VideoReply> deletevideoreply(Rodo_VideoReply reply, Model model, HttpSession session)
	{
		System.out.println("여기 와 안와");
		
		String id = (String)session.getAttribute("loginId");
		reply.setVideoreply_id(id);
		
		System.out.println("==================================");
		System.out.println(reply.toString());
		
		dao.deletevideoreply(reply);
		
		List<Rodo_VideoReply> list = dao.findreply(reply.getVideo_boardnum());
		
		return list;
	}
}