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



@WebServlet("/reporter/upload.html")
@MultipartConfig()
public class ImgUploadServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		final String SAVED_DIRECTORY = getServletContext().getRealPath("/imgdata");
		ReporterEmployeeVo user = (ReporterEmployeeVo)req.getSession().getAttribute("loginReporter");
		req.setCharacterEncoding("utf-8");
		
		Part part = req.getPart("file-upload");
		String imgname = req.getParameter("imgname");
		
		String saveFileName = System.currentTimeMillis() + "_" + imgname;
		
		long ImgSize = part.getSize();
		String item = part.getContentType();
		String fType = item.substring(item.indexOf("/")+1, item.length());
		if("jpeg".equals(fType)) fType = "jpg";
		String path = saveFileName + "." + fType;
		String markImgFileName = saveFileName + "_mark." + fType;
		part.write(SAVED_DIRECTORY + "/" + path);
		
		TbImageVo tbImageVo = new TbImageVo();
		tbImageVo.setImgLocation(req.getParameter("loc"));
		tbImageVo.setImgTitle(imgname);
		tbImageVo.setImgAlt(req.getParameter("contents"));
		tbImageVo.setImgPath(path);
		tbImageVo.setImgAlterState("N");
		
		tbImageVo.setReporter(user);
		
		NewsTypeVo newsType = new NewsTypeVo();
		newsType.setNewsTypeNo(Integer.parseInt(req.getParameter("newstype")));
		tbImageVo.setNewsType(newsType);
		
		NewsCategoryVo category = new NewsCategoryVo();
		category.setCategoryNo(Integer.parseInt(req.getParameter("newscat")));
		tbImageVo.setCategory(category);
		
		tbImageVo.setImgType(fType);
		tbImageVo.setImgSize(String.valueOf(ImgSize));
		
		TbImageDao dao = new TbImageDao();
		try {
			dao.addtbImageVo(tbImageVo);
			
			tbImageVo.setImgAlterState("Y");
			tbImageVo.setImgPath(markImgFileName);
			long alterImageSize = makeWaterMarkMakingAndReturnFileSize(SAVED_DIRECTORY + "\\" + path, markImgFileName, fType);
			tbImageVo.setImgSize(String.valueOf(alterImageSize));
			tbImageVo.setImgTitle("[수정]_"+imgname);
			
			dao.addtbImageVo(tbImageVo);
			
		} catch (SQLException e) {
			throw new ServletException(e);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	
		res.sendRedirect("/reporter/imageContainer/index.jsp");
	}
	
	
	private long makeWaterMarkMakingAndReturnFileSize(String path, String markImgFileName, String markFileType) {
		
		String markPath = getServletContext().getRealPath("/commons/img/") + "logo.png";
		String resultPath = getServletContext().getRealPath("/imgdata/") + markImgFileName;
		File imgFile = new File(path);
		File logoFile = new File(markPath);
		
		if(!imgFile.exists()) return -1;
		
			//-----------------------대상 이미지 획득
		try {
			Image src = ImageIO.read(imgFile);
			int width = src.getWidth(null);
			int height = src.getHeight(null);
			
			BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = image.createGraphics();
			g.drawImage(src, 0, 0, width, height, null);
			
			//-----------------------마크 이미지 획득
			Image markSrc = ImageIO.read(logoFile);
			int markWidth = markSrc.getWidth(null);
			int markHeight = markSrc.getHeight(null);
			
			
			int resultWidth = (int)(width * 0.3);
			int resultHeight = (int)((resultWidth / (double)markWidth) * markHeight);

			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, 1f));
			
			int x = (width - resultWidth) / 2;
			int y = (height - resultHeight) - (height / 10);
			
			BufferedImage markImage = resizeImage(markSrc, resultWidth, resultHeight);
			
			g.drawImage(markImage, x, y, resultWidth, resultHeight, null);
			
			g.dispose();
			File resultImg = new File(resultPath);
			ImageIO.write(image, markFileType, resultImg);
			
			return resultImg.length();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	private BufferedImage resizeImage(Image image, int resultWidth, int resultHeight) {
		
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
}
