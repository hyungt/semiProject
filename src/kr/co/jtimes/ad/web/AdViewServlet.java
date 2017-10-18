package kr.co.jtimes.ad.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.jtimes.ad.dao.AdDao;
import kr.co.jtimes.ad.vo.AdVo;
import kr.co.jtimes.common.criteria.AdCriteria;

@WebServlet("/reporter/AD/adViewservlet.html")
public class AdViewServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
	    res.setContentType("text/plain;charset=utf-8");
		String p = req.getParameter("page");
		String type = req.getParameter("type");
  
		AdCriteria adcriteria = new AdCriteria();
		adcriteria.setPage(Integer.valueOf(p));
		adcriteria.setType(type);
		List<AdVo> AdList = null;
		
		
			Gson gson = new Gson();
			PrintWriter out = res.getWriter();
			try {
				if("A".equals(type) ) {
					AdList = new AdDao().getAdByCriteria(adcriteria);
					out.println(gson.toJson(AdList));
				} else if("F".equals(type)){
					AdList = new AdDao().getAdDone(adcriteria);
					out.println(gson.toJson(AdList));
				} else {
					AdList = new AdDao().getAdByIng(adcriteria);
					out.println(gson.toJson(AdList));
				}
			} catch (Exception e) {
				 throw new ServletException(e);
			}
	}
}
