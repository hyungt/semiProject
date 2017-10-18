package kr.co.jtimes.ad.web;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import kr.co.jtimes.ad.dao.AdDao;
import kr.co.jtimes.ad.vo.AdVo;
         
@WebServlet("/reporter/AD/adupload.html")
@MultipartConfig()
public class AdUploadServlet extends HttpServlet{

   @Override
   protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
      
      final String SAVED_DIRECTORY = getServletContext().getRealPath("/img");
      
      req.setCharacterEncoding("utf-8");
      
      Part part = req.getPart("file-upload");
      String imgname = req.getParameter("imgname");
      String item = part.getContentType();
      String fType = item.substring(item.indexOf("/")+1, item.length());
      part.write(SAVED_DIRECTORY + "/" + imgname + "." + fType);
      
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
      Date startDate = null;
      try {
         startDate = dateFormat.parse(req.getParameter("submit-startDate"));
      } catch (ParseException e1) {
         e1.printStackTrace();
      }
      Date endDate = null;
      try {
         endDate = dateFormat.parse(req.getParameter("submit-endDate"));
      } catch (ParseException e1) {
         e1.printStackTrace();
      }
      
      long end = endDate.getTime();
      long start = startDate.getTime();
      String link = req.getParameter("submit-link");
      if(!"http://".contains(link) || !"https://".contains(link)) {
    	  link = "http://"+link;
      }
      AdVo adVo = new AdVo();
      adVo.setAdTitle(imgname);
      adVo.setAdImgPath(imgname + "." + fType);
      adVo.setAdLink(link);
      adVo.setAdStartDate(startDate);
      adVo.setAdEndDate(endDate);
      
      
      
      if(end > start) {
         AdDao adDao = new AdDao();
         try {
            adDao.addAd(adVo);
         } catch (SQLException e) {
            throw new ServletException(e);
         }
         res.sendRedirect("/reporter/AD/adAdd.jsp?success=1");
      } else {
    	  res.sendRedirect("/reporter/AD/adAdd.jsp?fail=1");
      } 
   }
}