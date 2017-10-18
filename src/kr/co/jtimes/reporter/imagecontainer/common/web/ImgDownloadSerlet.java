package kr.co.jtimes.reporter.imagecontainer.common.web;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import kr.co.jtimes.reporter.imagecontainer.common.dao.TbImageDao;
import kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo;


@WebServlet("/down.html")
public class ImgDownloadSerlet extends HttpServlet{
	
	

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		final String SAVED_DIRECTORY = getServletContext().getRealPath("/imgdata/");
		
		String path = req.getParameter("path");
		
		String filename = path;
		
		res.setContentType("application/octet-stream");
		res.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(filename, "utf-8"));
		
		ServletOutputStream os = res.getOutputStream();
		FileInputStream is = new FileInputStream(SAVED_DIRECTORY + filename);
		
		IOUtils.copy(is, os);
	}
}
