package kr.co.jtimes.news.dao;

import java.sql.SQLException;
import java.util.List;

import org.eclipse.jdt.internal.compiler.env.IBinaryTypeAnnotation;

import kr.co.jtimes.common.criteria.NewsCriteria;
import kr.co.jtimes.news.vo.TbNewsVo;
import kr.co.jtimes.news.vo.TemporaryNewsVo;
import kr.co.jtimes.util.IbatisUtil;

public class TbNewsDao {

	public TbNewsVo getNews(int no) throws SQLException {
		return (TbNewsVo) IbatisUtil.getSqlMap().queryForObject("getNews", no);
	}
	
	@SuppressWarnings("unchecked")
	public List<TbNewsVo> getTodayNewsList() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getTodayNewsList");
	}
	
	public void insertNews(TbNewsVo news) throws SQLException {
		IbatisUtil.getSqlMap().insert("insertNews", news);
	}
	
	public List<TbNewsVo> getNewsByWriterNo(NewsCriteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getNewsByWriterNo", criteria);
	}
	
	public List<TbNewsVo> getNewsByCategory(NewsCriteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getNewsByCategory", criteria);
	}
	
	public int getNewsCountAllByCategory(int categoryNo) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getNewsCountAllByCategory", categoryNo);
	}
	
	public int updateNews(TbNewsVo newsHit) throws SQLException {
		return IbatisUtil.getSqlMap().update("updateNews", newsHit);
	}
	
	public void updateToNews(TbNewsVo news) throws SQLException {
		IbatisUtil.getSqlMap().update("updateToNews", news);
	}
	
	public int getNewsNextSequence() throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getNewsNextSequence");
	}
	
	public TbNewsVo getNewsBack(int newsNo) throws SQLException {
		return (TbNewsVo)IbatisUtil.getSqlMap().queryForObject("getNewsBack", newsNo);
	}
	
	public List<TbNewsVo> getNewsByCategoryAndSign(NewsCriteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getNewsByCategoryAndSign", criteria);
	}
	
	public TbNewsVo getMainNews() throws SQLException {
		return (TbNewsVo) IbatisUtil.getSqlMap().queryForObject("getMainNews");
	}
	
	public List<TbNewsVo> getYesterdayImportantNewses() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getYesterdayImportantNewses");
	}
	
	public List<TemporaryNewsVo> getTemporaryNewsByReporterNo(int reporterNo) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getTemporaryNewsByReporterNo", reporterNo);
	}
	
	public TemporaryNewsVo getTemporaryNewsByNo(int no) throws SQLException {
		return (TemporaryNewsVo)IbatisUtil.getSqlMap().queryForObject("getTemporaryNewsByNo", no);
	}
	
	public void insertTemporaryNews(TemporaryNewsVo temporary) throws SQLException {
		IbatisUtil.getSqlMap().insert("insertTemporaryNews", temporary);
	}
	
	public void deleteTemporaryNews(int no) throws SQLException {
		IbatisUtil.getSqlMap().delete("deleteTemporaryNews", no);
	}
	
}
