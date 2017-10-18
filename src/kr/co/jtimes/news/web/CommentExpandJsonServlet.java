package kr.co.jtimes.news.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.jtimes.common.criteria.CommentCriteria;
import kr.co.jtimes.news.comment.Dao.CommentDao;
import kr.co.jtimes.news.comment.Dao.CommentLikeDao;
import kr.co.jtimes.news.comment.vo.ExpendResult;
import kr.co.jtimes.news.comment.vo.NewCommentVo;
import kr.co.jtimes.util.JsonDateConvertor;

@WebServlet("/article.do")
public class CommentExpandJsonServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int beginIndex = 0, endIndex= 0, newsNo= 0;
		try{
		beginIndex =  Integer.parseInt(request.getParameter("begin"));
		} catch(Exception e) {
			e.printStackTrace();
		}
		try{
		endIndex = Integer.parseInt(request.getParameter("end"));
		} catch(Exception e) {
			e.printStackTrace();
		}
		try{
		newsNo = Integer.parseInt(request.getParameter("newsNo"));
		} catch(Exception e) {
			e.printStackTrace();
		}
		// 펼치기를 눌렀을 때
		CommentCriteria criteria = new CommentCriteria();
		criteria.setBeginIndex(beginIndex);
		criteria.setEndIndex(endIndex);
		criteria.setNewsNo(newsNo);
		
		CommentDao dao = new CommentDao();
		try{
			response.setContentType("text/plain;charset=utf-8");
			List<NewCommentVo> commentList = dao.getCommentByNewsNo(criteria);
			PrintWriter pw = response.getWriter();
			
			CommentLikeDao commentLikeDao = new CommentLikeDao();
		   	for(NewCommentVo c : commentList) {
		   		c.setLikeCnt(commentLikeDao.getCommentLikeByCommentNo(c.getCommentNo(), "Y"));
		   		c.setDisLikeCnt(commentLikeDao.getCommentLikeByCommentNo(c.getCommentNo(), "N"));
		   	}
		   	
		   	CommentDao commentDao = new CommentDao();
		   	int total = commentDao.getTotalCommentRows(newsNo);
		   	boolean con = true;
		   	if( total < endIndex) con = false;
		   	
		   	ExpendResult result = new ExpendResult();
		   	result.setCommentList(commentList);
		   	result.setContinueExpand(con);
		   	
		   	
		   	GsonBuilder builder = new GsonBuilder();
			builder.registerTypeAdapter(Date.class, new JsonDateConvertor());
			Gson gson = builder.create();
		   	
			String text = gson.toJson(result);
			
			pw.write(text);
		} catch (Exception e) {
			
		}
		
	}
}
