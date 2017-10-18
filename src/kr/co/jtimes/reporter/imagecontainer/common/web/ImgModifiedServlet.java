package kr.co.jtimes.reporter.imagecontainer.common.web;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import kr.co.jtimes.common.vo.NewsCategoryVo;
import kr.co.jtimes.common.vo.NewsTypeVo;
import kr.co.jtimes.reporter.imagecontainer.common.dao.TbImageDao;
import kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo;
import kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo;



@WebServlet("/reporter/modified.html")
@MultipartConfig()
public class ImgModifiedServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		// 이미지파일경로
		final String SAVED_DIRECTORY = getServletContext().getRealPath("/imgdata");
		// 로그인세션 유지
		ReporterEmployeeVo user = (ReporterEmployeeVo)req.getSession().getAttribute("loginReporter");
		// 인코팅 utf-8
		req.setCharacterEncoding("utf-8");
		
		// 파일은 getparameter로 불러올 수 없어서 getpart를 사용, getPart에서 나오는 값 = 타입, 사이즈, 파일이름.파일타입
		Part part = req.getPart("file-upload");
		// 이미지 이름 가져오기
		String imgname = req.getParameter("imgname");
		
		// 이미지이름 앞에 밀리초단위를 붙여 고유값을 만듬 
		String saveFileName = imgname;
		
		// 이미지크기설정
		long ImgSize = part.getSize();
		// 이미지타입을 받음 ex) images/jpg
		String item = part.getContentType();
		// ex) images/jpg "/"위치의길이을 숫자로 나타냄, 확장자를 빼내는 메소드
		String fType = item.substring(item.indexOf("/")+1, item.length());
		// 타입이 jpeg면 jpg로 변경
		if("jpeg".equals(fType)) fType = "jpg";
		
		// 이미지파일이름에.을 붙이고 확장자를 붙임 (원본파일이름)
		String path = saveFileName + "." + fType;
		// 워터마크를 넣은 이미지 이름
		// String markImgFileName = saveFileName + "_mark." + fType;
		// 이미지파일을 해당경로에 저장
		part.write(SAVED_DIRECTORY + "/" + path);
		
		// vo객체 생성
		TbImageVo tbImageVo = new TbImageVo();
		// vo객체location에 국내/해외를 저장
		tbImageVo.setImgLocation(req.getParameter("loc"));
		// vo객체에 이미지title을 저장
		tbImageVo.setImgTitle(imgname);
		// vo객체에 이미지내용을 저장
		tbImageVo.setImgAlt(req.getParameter("contents"));
		// vo객체에 이미지경로를 저장
		tbImageVo.setImgPath(path);
		// vo객체에 이미지원본/수정본인지 저장
		tbImageVo.setImgAlterState("Y");
		
		// vo객체에 유저번호를 저장
		tbImageVo.setReporter(user);
		
		// 일반, 특보, 속보 vo객체생성
		NewsTypeVo newsType = new NewsTypeVo();
		// 타입번호저장
		newsType.setNewsTypeNo(Integer.parseInt(req.getParameter("newstype")));
		// 타입이름저장
		tbImageVo.setNewsType(newsType);
		
		// 시사,경제,연예,스포츠 vo객체 생성
		NewsCategoryVo category = new NewsCategoryVo();
		// 카테고리번호저장
		category.setCategoryNo(Integer.parseInt(req.getParameter("newscat")));
		// 키테고리이름저장
		tbImageVo.setCategory(category);
		
		// 확장자명저장
		tbImageVo.setImgType(fType);
		// 이미지크기저장
		tbImageVo.setImgSize(String.valueOf(ImgSize));
		
		// dao객체 생성
		TbImageDao dao = new TbImageDao();
		try {
			// dao에 addtbImageVo메소드 실행
			dao.addtbImageVo(tbImageVo);
			
			// 원본/수정본선택
			//tbImageVo.setImgAlterState("Y");
			// 이미지 경로등록
			//tbImageVo.setImgPath(markImgFileName);
			// 워터마크가 박힌 이미지의 사이즈를 구하는 메소드
			//long alterImageSize = makeWaterMarkMakingAndReturnFileSize(SAVED_DIRECTORY + "\\" + path, markImgFileName, fType);
			// 숫자형을 문자열로 반환받음
			//tbImageVo.setImgSize(String.valueOf(alterImageSize));
			// 이미지타이틀 앞에 수정이라는 값을 넣음 
			//tbImageVo.setImgTitle("[수정]_"+imgname);
			
			// addtbImageVo메소드 실행
			//dao.addtbImageVo(tbImageVo);
			
		} catch (SQLException e) {
			throw new ServletException(e);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		// /reporter/imageContainer/index.jsp경로로 다시 되돌아감
		res.sendRedirect("/reporter/imageContainer/index.jsp");
	}
}
	
	// 이미지사이즈를 반환받는 메소드
	/*private long makeWaterMarkMakingAndReturnFileSize(String path, String markImgFileName, String markFileType) {
		
		// 서블릿컨텍스트에 진짜경로를 가져옴, 워터마크의 이미지 경로를 가져옴
		String markPath = getServletContext().getRealPath("/commons/img/") + "logo.png";
		// 워터마크를 박은 이미지의 저장경로
		String resultPath = getServletContext().getRealPath("/imgdata/") + markImgFileName;
		// 이미지파일 객체생성
		File imgFile = new File(path);
		// 로고파일 객체생성
		File logoFile = new File(markPath);
		
		// 파일의 존재여부확인
		if(!imgFile.exists()) return -1;
		
			//-----------------------대상 이미지 획득
		try {
			// 원본이미지파일을 읽어옴
			Image src = ImageIO.read(imgFile);
			int width = src.getWidth(null);
			int height = src.getHeight(null);
			
			// 가상의 이미지를 생성하여 수정본을 만듬
			BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = image.createGraphics();
			g.drawImage(src, 0, 0, width, height, null);
			
			//-----------------------마크 이미지 획득
			// 워터마크이미지파일을 읽어옴
			Image markSrc = ImageIO.read(logoFile);
			int markWidth = markSrc.getWidth(null);
			int markHeight = markSrc.getHeight(null);
			
			// 워터마크이미지 사이즈획득
			int resultWidth = (int)(width * 0.3);
			int resultHeight = (int)((resultWidth / (double)markWidth) * markHeight);
			
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, 1f));
			
			// 워터마크 위치조정
			int x = (width - resultWidth) / 2;
			int y = (height - resultHeight) - (height / 10);
			
			// 사이즈만큼 워터마크이미지 조정 (가상의 이미지 획득)
			BufferedImage markImage = resizeImage(markSrc, resultWidth, resultHeight);
			
			// 원본이미지의 가상이미지위에 가상의 워터마크이미지를 적용
			g.drawImage(markImage, x, y, resultWidth, resultHeight, null);
			
			
			g.dispose();
			// 가상의 이미지를 파일로 획득
			File resultImg = new File(resultPath);
			ImageIO.write(image, markFileType, resultImg);
			
			// 이미지사이즈를 반환받음
			return resultImg.length();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}*/
	
	// 워터마크의 이미지 사이즈 조정하는 메소드
	/*private BufferedImage resizeImage(Image image, int resultWidth, int resultHeight) {
		
		Image highQualityLogo = image.getScaledInstance(resultWidth, resultHeight, Image.SCALE_SMOOTH);
		int pixel[] = new int[resultWidth * resultHeight];
		PixelGrabber pg = new PixelGrabber(highQualityLogo, 0, 0, resultWidth, resultHeight, pixel, 0, resultWidth);
		try {
			pg.grabPixels();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		final BufferedImage bufImg = new BufferedImage(resultWidth, resultHeight, BufferedImage.TYPE_INT_ARGB);
		final Graphics2D g = bufImg.createGraphics();
		g.setComposite(AlphaComposite.Src);

		g.drawImage(highQualityLogo, 0, 0, resultWidth, resultHeight, null);
		g.dispose();
		                                                                                                                                                                                                                                                                                                                                                                                                             
		return bufImg;
	} 
}*/

