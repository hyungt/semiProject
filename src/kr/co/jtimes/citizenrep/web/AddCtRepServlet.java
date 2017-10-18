package kr.co.jtimes.citizenrep.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jtimes.citizenrep.dao.CitizenRepDao;
import kr.co.jtimes.citizenrep.vo.CitizenRepVo;
import kr.co.jtimes.profile.common.vo.UserVo;

@WebServlet("/citizenrep/addctrep.html")
@MultipartConfig()
public class AddCtRepServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession(false);
		UserVo userVo = (UserVo) session.getAttribute("userLogin");
		String title = req.getParameter("title");
		String contents = req.getParameter("ir1");
		
		CitizenRepVo citizenRepVo = new CitizenRepVo();
		
		citizenRepVo.setCitizenRepTitle(title);
		citizenRepVo.setCitizenRepContents(contents);
		citizenRepVo.setWriter(userVo);
		
		CitizenRepDao citizenRepDao = new CitizenRepDao();
		try {
			citizenRepDao.addCitizenRep(citizenRepVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		res.sendRedirect("/citizenrep/list.jsp");
		
	}
	
}
