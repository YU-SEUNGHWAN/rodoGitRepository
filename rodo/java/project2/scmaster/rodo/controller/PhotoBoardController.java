package project2.scmaster.rodo.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project2.scmaster.rodo.dao.PhotoBoardDAO;
import project2.scmaster.rodo.util.FileService;
import project2.scmaster.rodo.vo.Board;

@Controller
public class PhotoBoardController {

	
	private static final Logger logger = LoggerFactory.getLogger(PhotoBoardController.class);
	final String uploadPath = "/boardfile"; // 파일 업로드 경로
	final String tnUploadPath = "/thumbnail";// 섬네일 업로드 경로
	
	@Autowired
	PhotoBoardDAO dao;
	
	@RequestMapping(value = "readPhoto", method = RequestMethod.GET)
	public String readGps(){
		
		return "readPhoto";
	}

	@RequestMapping(value = "writePhoto", method = RequestMethod.GET)
	public String writePhoto(){
		
		return "./photo/writePhoto";
	}

	@ResponseBody
	@RequestMapping(value = "fileupload", method = RequestMethod.POST)
	public Board fileupload(MultipartHttpServletRequest request, HttpServletResponse response) {
		Iterator<String> itr = request.getFileNames();
		String OriginalFilename = ""; // 내가 저장할 파일의 이름.(hi.jpg)
		String Serversavedfile = ""; // 서버에 저장할 날짜로 이름이 바뀌어 저장되는
										// 파일.(170329//////////////////)
		String Savedfile = "";
		String tn = "";// 서버에 저장할 섬네일 파일의 이름.
		Board board = new Board();
		while (itr.hasNext()) {
			MultipartFile mpf = request.getFile(itr.next());
			System.out.println(mpf.getOriginalFilename() + " uploaded!");
			try {
				System.out.println("file length : " + mpf.getBytes().length);
				System.out.println("file name : " + mpf.getOriginalFilename());
				if (!mpf.isEmpty()) {
					Serversavedfile = FileService.saveFile(mpf, uploadPath);
					String onetimeTN = thumbnail(Serversavedfile);// 서버에 저장하는
																	// 파일을 보내
																	// 섬네일파일의
																	// 이름을 가져옴.
					// System.out.println(onetimeTN);
					OriginalFilename += mpf.getOriginalFilename() + ":";
					Savedfile += Serversavedfile + ":";
					tn += onetimeTN + ":";
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		board.setOriginalfile(OriginalFilename);
		// System.out.println("내가 저장한 파일 이름 : " + OriginalFilename);
		board.setSavedfile(Savedfile);
		// System.out.println("내가 서버에 저장한 파일 이름 : " + Savedfile);
		board.setTn(tn);
		System.out.println("내가 서버에 저장된 섬네일 이름 : " + tn);
		dao.Photoinsert(board);
		return board;
	}

	@RequestMapping(value = "download", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin, String tn) {
		try {
			System.out.println(origin);
			System.out.println(tn);
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
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		FileInputStream filein1 = null;
		ServletOutputStream fileout1 = null;

		try {
			filein = new FileInputStream(originPath.get(0));
			fileout = response.getOutputStream();
			filein1 = new FileInputStream(tnPath.get(0) + ".jpg");
			fileout1 = response.getOutputStream();

			// Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein1, fileout1);
			// FileCopyUtils.copy(filein1, fileout1);

			filein.close();
			fileout.close();
			filein1.close();
			fileout1.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String thumbnail(String Savedfile) {
		String thumbnailImgN = "";
		try {
			File originalFileNm = new File("c:/" + uploadPath + "/" + Savedfile);
			// System.out.println(originalFileNm);
			thumbnailImgN = Savedfile.substring(0, Savedfile.length() - 4) + "_tmb";

			File thumbnailFileNm = new File("c:/" + tnUploadPath + "/" + thumbnailImgN + ".jpg");
			int width = 250;
			int height = 250;
			// 썸네일 이미지 생성
			BufferedImage originalImg = ImageIO.read(originalFileNm);
			BufferedImage thumbnailImg = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
			// 썸네일 그리기
			Graphics2D g = thumbnailImg.createGraphics();
			g.drawImage(originalImg, 0, 0, width, height, null);
			// 파일생성
			ImageIO.write(thumbnailImg, "jpg", thumbnailFileNm);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return thumbnailImgN;
	}
}