package kr.co.jtimes.reporter.imagecontainer.common.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.jtimes.common.criteria.Criteria;
import kr.co.jtimes.reporter.imagecontainer.common.dao.TbImageDao;
import kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo;

@WebServlet("/expend.do")
public class ExpendJsonServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int beginIndex = Integer.parseInt(req.getParameter("bino"));
		int endIndex = Integer.parseInt(req.getParameter("eino"));
		String tapId = req.getParameter("tapid");
		
		Criteria criteria = new Criteria();
		criteria.setBeginIndex(beginIndex);
		criteria.setEndIndex(endIndex);
		criteria.setTapId(tapId);
		
		TbImageDao tbImageDao = new TbImageDao();
		List<TbImageVo> imgList = null;
		try {
			imgList = tbImageDao.getSearchBySelectSort(criteria);
			res.setContentType("text/plain;charset=utf-8");
			PrintWriter pw = res.getWriter();
			
			Gson gson = new Gson();
			pw.write(gson.toJson(imgList));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
}
