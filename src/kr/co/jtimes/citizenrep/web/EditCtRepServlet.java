package kr.co.jtimes.citizenrep.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jtimes.citizenrep.dao.CitizenRepDao;
import kr.co.jtimes.citizenrep.vo.CitizenRepVo;

@WebServlet("/citizenrep/edit.html")
@MultipartConfig()
public class EditCtRepServlet extends HttpServlet{

	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		String title = req.getParameter("title");
		String contents = req.getParameter("ir1");
		int no = Integer.parseInt(req.getParameter("crno"));
		
		
		try {
			CitizenRepDao citizenRepDao = new CitizenRepDao();
			CitizenRepVo citizenRepVo = citizenRepDao.getCitRepByNo(no);
			citizenRepVo.setCitizenRepTitle(title);
			citizenRepVo.setCitizenRepContents(contents);
			citizenRepDao.editCitRep(citizenRepVo);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(no==0){
			res.sendRedirect("/citizenrep/gongji.jsp");
		} else{
		res.sendRedirect("/citizenrep/detail.jsp?bno="+no);
		}
	}
	
}
