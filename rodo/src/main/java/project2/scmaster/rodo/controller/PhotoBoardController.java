package project2.scmaster.rodo.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.dao.Rodo_PhotoBoardDAO;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.vo.Rodo_PhotoBoard;
import project2.scmaster.rodo.vo.Rodo_PhotoReply;

@Controller
public class PhotoBoardController {

	private static final Logger logger = LoggerFactory.getLogger(PhotoBoardController.class);
	final String uploadPath = "/boardfile"; // 파일 업로드 경로
	final String tnUploadPath = "/thumbnail";// 섬네일 업로드 경로
	
	@Autowired
	Rodo_PhotoBoardDAO dao;
	
	@RequestMapping(value = "readPhoto", method = RequestMethod.GET)
	public String readPhoto(HttpSession session, Model model, int photo_boardnum)
	{
		System.out.println(photo_boardnum);
		Rodo_PhotoBoard pt_board = dao.readPhoto(photo_boardnum);
		ArrayList<HashMap> fileList = dao.PhotoFileList(photo_boardnum);

		ArrayList<String> oglist = new ArrayList<>();
		ArrayList<String> svlist = new ArrayList<>();
		
		for(HashMap file : fileList)
		{
			System.out.println((String)file.get("PHOTOFILE_SAVED"));
			oglist.add((String)file.get("PHOTOFILE_ORIGINAL"));
			svlist.add((String)file.get("PHOTOFILE_SAVED"));
		}
		
		System.out.println(oglist);
		System.out.println(svlist);
		
		pt_board.setPhotofile_original(oglist);
		pt_board.setPhotofile_saved(svlist);
		
		List<Rodo_PhotoReply> replylist = dao.findreply(photo_boardnum);
		
		model.addAttribute("pt_board", pt_board);
		model.addAttribute("id", (String)session.getAttribute("loginId"));
		model.addAttribute("replylist", replylist);
		
		return "readPhoto";
	}

	@RequestMapping(value = "writePhoto", method = RequestMethod.GET)
	public String writePhoto(){
		return "/photo/writePhoto";
	}
	
	@ResponseBody
	@RequestMapping(value = "writePhoto", method = RequestMethod.POST)
	public String writePhoto(Rodo_PhotoBoard board, HttpSession session, Model model, 
			MultipartHttpServletRequest request, HttpServletResponse response){
		String id = (String)session.getAttribute("loginId");
		board.setPhoto_id(id);
		
			Iterator<String> itr = request.getFileNames();
			
			String OriginalFilename = ""; // 내가 저장할 파일의 이름.(hi.jpg)
			String Serversavedfile = ""; // 서버에 저장할 날짜로 이름이 바뀌어 저장되는
											// 파일.(170329//////////////////)
			
			ArrayList<String> originalFile = new ArrayList<>(); // vo에 담을 OriginalFile
			ArrayList<String> savedFile = new ArrayList<>(); // vo에 담을 SavedFile
			String tnFile = ""; // vo에 담을 ThumbNailFile
			
			
			while (itr.hasNext()) { //만약 파일이 있다면
				MultipartFile mpf = request.getFile(itr.next()); // 리퀘스트에서 파일을 하나씩 가져옴.
				System.out.println("유저가 저장한 원본파일이름 : " + mpf.getOriginalFilename() + " uploaded!");
				if (!mpf.isEmpty()) { // 역시 파일이 있다면.
					Serversavedfile = FileService.saveFile(mpf, uploadPath); //파일을 업로드패쓰의 경로에 저장.
																			//이때 오늘의 등록날짜시간으로 저장.
					// 서버폴더에 저장하는 파일(바뀐 이름)을 보내서 섬네일파일의 이름을 가져옴.
					// 확장자가 없는 섬네일의 이름임.
					String onetimeTN = thumbnail(Serversavedfile) + ".jpg";
					//포토보드의 vo에 저장할 어레이리스트 세팅.
					originalFile.add(mpf.getOriginalFilename());
					savedFile.add(Serversavedfile);
					tnFile += onetimeTN + ":";
				}
			}
			
			board.setPhotofile_original(originalFile);
			board.setPhotofile_saved(savedFile);
			board.setPhotofile_tn(tnFile);
			
			int doroku = 0;
			int boardNum = 0;
			
			doroku = dao.PhotoInsertBoard(board);
			if(doroku==1){
				boardNum = dao.PhotoSelelctBoardnum();
				board.setPhoto_boardnum(boardNum);
				int a = dao.PhotofileInsertBoard(board);
				 if(a != 0){
					 return "success";
				 }
			}
		return "fail";
	}

	@RequestMapping(value = "upload", method = RequestMethod.GET)
	public String upload() {
		return "upload";
	}

	@RequestMapping(value = "download", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin, String tn) {
		try {
			System.out.println("세이브파일 안자른거 : " + origin);
			System.out.println("섬네일파일 안자른거 : " + tn);
			response.setHeader("Content-Disposition", " attachment;filename=" + URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String[] originSTB = origin.split("[:]");
		String[] originTNB = tn.split("[:]");

		String OriginfullPath = null;
		String ThumbNailfullPath = null;
		
		ArrayList<String> originPath = new ArrayList<>();
		ArrayList<String> tnPath = new ArrayList<>();
		
		for (int OriginCnt = 0; OriginCnt < originSTB.length; OriginCnt++) {
			OriginfullPath = uploadPath + "/" + originSTB[OriginCnt]; // 원래파일
			originPath.add(OriginfullPath);
		}
		
		for (int tnCnt = 0; tnCnt < originTNB.length; tnCnt++) {
			ThumbNailfullPath = tnUploadPath + "/" + originTNB[tnCnt]; // 섬네일파일
			tnPath.add(ThumbNailfullPath);
		}
		// 서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein0 = null;
		ServletOutputStream fileout0 = null;

		try {
			filein0 = new FileInputStream(tnPath.get(0));
			fileout0 = response.getOutputStream();

			// Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein0, fileout0);

			filein0.close();
			fileout0.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String thumbnail(String Savedfile) {
		String thumbnailImgN = "";
		try {
			//서버의 폴더의 경로에 있는 바뀐 날짜로 저장되어있는 파일을 가져옴(준비)   
			File originalFileNm = new File("c:/" + uploadPath + "/" + Savedfile);
			System.out.println("섬네일만들 이름바뀐 오리지날 파일 : " + originalFileNm);
			//섬네일파일의 이름을 만들기 위해 저장되어있는 파일의 이름을 가져와서 확장자를 자르고 뒤에 _tmb를 붙임
			thumbnailImgN = Savedfile.substring(0, Savedfile.length() - 4) + "_tmb";
			System.out.println("섬네일이 될 준비하는 파일 : " + thumbnailImgN);
			//서버에 저장될 섬네일파일을 준비
			File thumbnailFileNm = new File("c:/" + tnUploadPath + "/" + thumbnailImgN + ".jpg");
			System.out.println("섬네일 파일 : " + thumbnailFileNm);
			//섬네일의 사이즈를 지정
			int width = 250; int height = 250;
			
			//썸네일 이미지 생성-------
				//오리지날 파일을 읽어서 버퍼이미지를 준비.
				BufferedImage originalImg = ImageIO.read(originalFileNm);
				//지정한 사이즈로 섬네일만들기를 준비.
				BufferedImage thumbnailImg = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

			// 썸네일 그리기
				//지정한 형식으로 준비해둠.
				Graphics2D g = thumbnailImg.createGraphics();
				//준비해둔 형식에 따라 오리지널 파일을 섬네일 파일로 그림.
				g.drawImage(originalImg, 0, 0, width, height, null);

			// 파일생성
			ImageIO.write(thumbnailImg, "jpg", thumbnailFileNm);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//섬네일 파일명(확장자 없는거)를 리턴함.
		return thumbnailImgN;
	}
	
	@RequestMapping(value = "photoLoad", method = RequestMethod.GET)
	public void photoLoad(HttpServletResponse response, String origin) {
		try {
			response.setHeader("Content-Disposition", " attachment;filename=" + URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String OriginfullPath = uploadPath + "/" + origin; // 원래파일
		
		// 서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein0 = null;
		ServletOutputStream fileout0 = null;

		try {
			filein0 = new FileInputStream(OriginfullPath);
			fileout0 = response.getOutputStream();

			// Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein0, fileout0);

			filein0.close();
			fileout0.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "deletePhoto", method = RequestMethod.GET)
	public String deletePhoto(int photo_boardnum){
		ArrayList<HashMap> fileList = dao.PhotoFileList(photo_boardnum);

		ArrayList<String> oglist = new ArrayList<>();
		ArrayList<String> svlist = new ArrayList<>();
		
		for(HashMap file : fileList){
			oglist.add((String)file.get("PHOTOFILE_ORIGINAL"));
			svlist.add((String)file.get("PHOTOFILE_SAVED"));
		}
		for(int i = 0; i<oglist.size(); i++){
			FileService.deleteFile(oglist.get(i));
			FileService.deleteFile(svlist.get(i));
		}
		
		dao.deletePhoto(photo_boardnum);
		return "redirect:photoBoard";
	}
	
	@RequestMapping(value = "updatePhoto", method = RequestMethod.GET)
	public String updatePhoto(int photo_boardnum, Model model){
		Rodo_PhotoBoard board = dao.readPhoto(photo_boardnum);
		model.addAttribute("board", board);
		return "photo/updatePhoto";
	}
	
	@ResponseBody
	@RequestMapping(value = "updatePhoto", method = RequestMethod.POST)
	public String updatePhoto(Rodo_PhotoBoard board, 
			MultipartHttpServletRequest request, HttpServletResponse response){

		Iterator<String> itr = request.getFileNames();
		
		System.out.println(board.toString() + "asdfadfs"); 
		String OriginalFilename = ""; // 내가 저장할 파일의 이름.(hi.jpg)
		String Serversavedfile = ""; // 서버에 저장할 날짜로 이름이 바뀌어 저장되는
										// 파일.(170329//////////////////)
		
		ArrayList<String> originalFile = new ArrayList<>(); // vo에 담을 OriginalFile
		ArrayList<String> savedFile = new ArrayList<>(); // vo에 담을 SavedFile
		String tnFile = ""; // vo에 담을 ThumbNailFile
		
		
		while (itr.hasNext()) { //만약 파일이 있다면
			MultipartFile mpf = request.getFile(itr.next()); // 리퀘스트에서 파일을 하나씩 가져옴.
			System.out.println("유저가 저장한 원본파일이름 : " + mpf.getOriginalFilename() + " uploaded!");
			if (!mpf.isEmpty()) { // 역시 파일이 있다면.
				Serversavedfile = FileService.saveFile(mpf, uploadPath); //파일을 업로드패쓰의 경로에 저장.
																		//이때 오늘의 등록날짜시간으로 저장.
				// 서버폴더에 저장하는 파일(바뀐 이름)을 보내서 섬네일파일의 이름을 가져옴.
				// 확장자가 없는 섬네일의 이름임.
				String onetimeTN = thumbnail(Serversavedfile) + ".jpg";
				//포토보드의 vo에 저장할 어레이리스트 세팅.
				originalFile.add(mpf.getOriginalFilename());
				savedFile.add(Serversavedfile);
				tnFile += onetimeTN + ":";
			}
		}
		
		board.setPhotofile_original(originalFile);
		board.setPhotofile_saved(savedFile);
		board.setPhotofile_tn(tnFile);
		System.out.println(board.getPhotofile_original());
		System.out.println(board.getPhotofile_saved());
		System.out.println(board.getPhotofile_tn());
		int i = dao.updatePhoto(board);
			 
		 if(i!=0){
			 return "success";
		 }
		 return "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="writephotoreply", method=RequestMethod.POST)
	public List<Rodo_PhotoReply> writephotoreply(Rodo_PhotoReply reply, HttpSession session, Model model)
	{
		System.out.println("==============================");
		System.out.println(reply.toString());
		
		String id = (String)session.getAttribute("loginId");
		reply.setPhotoreply_id(id);
		
		dao.writephotoreply(reply);
		
		List<Rodo_PhotoReply> list = dao.findreply(reply.getPhoto_boardnum());
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "deletephotoreply", method = RequestMethod.GET)
	public List<Rodo_PhotoReply> deletephotoreply(Rodo_PhotoReply reply, HttpSession session, Model model)
	{		
		String id = (String)session.getAttribute("loginId");
		reply.setPhotoreply_id(id);
		
		System.out.println(reply.toString());
		
		dao.deletereply(reply);
		
		List<Rodo_PhotoReply> list = dao.findreply(reply.getPhoto_boardnum());
		
		System.out.println("==============================");
		System.out.println(list);
		
		return list;
	}
}