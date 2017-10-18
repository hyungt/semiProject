package kr.co.jtimes.news.test;

import java.util.List;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import kr.co.jtimes.common.criteria.NewsCriteria;
import kr.co.jtimes.news.dao.TbNewsDao;
import kr.co.jtimes.news.vo.TbNewsVo;

public class SimpleTest {

	private TbNewsDao newsDao;
	
	
	@Before
	public void setup() {
		newsDao = new TbNewsDao();
	}
	
	@Test
	public void testOne() throws Exception {
		final int rowsPerPage = 5, naviPerPage = 5;
		TbNewsDao newsDao = new TbNewsDao();
		
		int category_no = 20;
		int page_no = 1;
		int totalRow = newsDao.getNewsCountAllByCategory(category_no);
		int totalPages = (int)Math.ceil((double)totalRow / rowsPerPage);
		
		if(page_no > totalPages) {
			page_no = 1;
		}
		
		int beginIndex = (page_no - 1) * rowsPerPage + 1; 
		int endIndex = page_no * rowsPerPage;
		
		NewsCriteria criteria = new NewsCriteria();
		criteria.setBeginIndex(beginIndex);
		criteria.setEndIndex(endIndex);
		criteria.setCategoryNo(category_no);
		
		List<TbNewsVo> newsList = newsDao.getNewsByCategory(criteria);
		
		Assert.assertEquals(5, newsList.size());
	}
	
	@After
	public void tearDown() {
		System.out.println("after...");
	}
	
}
