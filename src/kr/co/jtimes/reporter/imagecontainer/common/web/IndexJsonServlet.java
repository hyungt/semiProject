package kr.co.jtimes.reporter.imagecontainer.common.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.jtimes.common.criteria.Criteria;
import kr.co.jtimes.reporter.imagecontainer.common.dao.TbImageDao;
import kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo;
import kr.co.jtimes.util.JsonDateConvertor;

@WebServlet("/index.do")
public class IndexJsonServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");		
		
		String expendId = req.getParameter("expendId");
		String tapId = req.getParameter("tapid");
		int beginIndex = Integer.parseInt(req.getParameter("bino"));
		int endIndex = Integer.parseInt(req.getParameter("eino"));
		String categoryId = req.getParameter("categoryId");
		String titleAuthorCategory = req.getParameter("opt");
		String searchWord = req.getParameter("keyword");
		String beginDate = req.getParameter("beginDate");
		String endDate = req.getParameter("endDate");
		String png = req.getParameter("png");
		String jpg = req.getParameter("jpg");
		String bmp = req.getParameter("bmp");
		String gif = req.getParameter("gif");
		
		List<String> fileTypeList = new ArrayList<>();
		
		if("nopng".equals(png) && "nojpg".equals(jpg) && "nobmp".equals(bmp) && "nogif".equals(gif)) {
			png = "png";
			jpg = "jpg";
			bmp = "bmp";
			gif = "gif";
		}
		
		if(png == null && jpg == null && bmp == null && gif == null) {
			png = "png";
			jpg = "jpg";
			bmp = "bmp";
			gif = "gif";
		}
		
		
		
		fileTypeList.add(png);
		fileTypeList.add(jpg);
		fileTypeList.add(bmp);
		fileTypeList.add(gif);
		
		
		
		
		
		
		TbImageDao tbImageDao = new TbImageDao();
		Criteria criteria = new Criteria();
		
		
		// 펼치기를 눌렀을 때 실행
				if("expend".equals(expendId)) {
					criteria.setBeginIndex(beginIndex);
					criteria.setEndIndex(endIndex);
					criteria.setTapId(tapId);
					
					
						// 카테고리의 전체 버튼을 눌렀을 때
						if("categoryAll".equals(categoryId) || categoryId == null || "".equals(categoryId)){
							criteria.setCategoryAll(categoryId);
							
							criteria.setTapId(tapId);
							criteria.setBeginIndex(beginIndex);
							criteria.setEndIndex(endIndex);
							criteria.setTitleAuthorCategory(titleAuthorCategory);
							criteria.setSearchWord(searchWord);
							criteria.setBeginDate(beginDate);
							criteria.setEndDate(endDate);
							criteria.setExtension(fileTypeList);
							
							
						// 카테고리의 전체버튼을 누르지 않았을 때
						}else {
							
							
							criteria.setCategoryRemainder(categoryId);
							
							criteria.setTapId(tapId);
							criteria.setBeginIndex(beginIndex);
							criteria.setEndIndex(endIndex);
							criteria.setTitleAuthorCategory(titleAuthorCategory);
							criteria.setSearchWord(searchWord);
							criteria.setBeginDate(beginDate);
							criteria.setEndDate(endDate);
							criteria.setExtension(fileTypeList);
							
						}
					
				// 펼치기를 누르지 않았을 때 실행
				}else{
					// 카테고리의 전체 버튼을 눌렀을 때
					if("categoryAll".equals(categoryId) || categoryId == null || "".equals(categoryId)){
						criteria.setCategoryAll(categoryId);
						
						criteria.setTapId(tapId);
						criteria.setBeginIndex(beginIndex);
						criteria.setEndIndex(endIndex);
						criteria.setTitleAuthorCategory(titleAuthorCategory);
						criteria.setSearchWord(searchWord);
						criteria.setBeginDate(beginDate);
						criteria.setEndDate(endDate);
						criteria.setExtension(fileTypeList);
						
						
						
					// 카테고리의 전체버튼을 누르지 않았을 때
					}else {
						
						
						criteria.setCategoryRemainder(categoryId);
						
						criteria.setTapId(tapId);
						criteria.setBeginIndex(beginIndex);
						criteria.setEndIndex(endIndex);
						criteria.setTitleAuthorCategory(titleAuthorCategory);
						criteria.setSearchWord(searchWord);
						criteria.setBeginDate(beginDate);
						criteria.setEndDate(endDate);
						criteria.setExtension(fileTypeList);
						
						
					}
					
				}
				
				try {
					List<TbImageVo> imageVos = tbImageDao.getSearchBySelectSort(criteria);
					for (TbImageVo tbImageVo : imageVos) {
						String a = tbImageVo.getImgAlt();
						String b = tbImageVo.getCategory().getCategoryName();
					}
					res.setContentType("text/plain;charset=utf-8");
					PrintWriter pw = res.getWriter();
					
					GsonBuilder builder = new GsonBuilder();
					builder.registerTypeAdapter(Date.class, new JsonDateConvertor());
					Gson gson = builder.create();
					
					
					pw.write(gson.toJson(imageVos));
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
