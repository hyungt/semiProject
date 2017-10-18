package kr.co.jtimes.reporter.sign.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.common.criteria.SignCriteria;
import kr.co.jtimes.reporter.sign.vo.NewsSignVo;
import kr.co.jtimes.util.IbatisUtil;

public class NewsSignDao {

	public void insertNewsSign(NewsSignVo newsSign) throws SQLException {
		IbatisUtil.getSqlMap().insert("insertNewsSign", newsSign);
	}
	
	public List<NewsSignVo> getFirstSignList(int signerNo) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getFirstSignList", signerNo);
	}
	
	public List<NewsSignVo> getSecondSignList(int signerNo) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getSecondSignList", signerNo);
	}
	
	public List<NewsSignVo> getFirstSignListByState(SignCriteria criteria) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getFirstSignListByState", criteria);
	}
	
	public List<NewsSignVo> getSecondSignListByState(SignCriteria criteria) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getSecondSignListByState", criteria);
	}
	
	public List<NewsSignVo> getSignListByReporterNo(SignCriteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getSignListByReporterNo", criteria);
	}
	
	public int getTotalFirtsRows(SignCriteria criteria) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getTotalFirtsRows", criteria);
	}
	public int getTotalSecondRows(SignCriteria criteria) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getTotalSecondRows", criteria);
	}
	public int getTotalSignRowByReporterNo(int reporterNo) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getTotalSignRowByReporterNo", reporterNo);
	}
	
	public NewsSignVo getNewsSign(int no) throws SQLException {
		return (NewsSignVo)IbatisUtil.getSqlMap().queryForObject("getNewsSign", no);
	}
	
	public NewsSignVo getNewsSignByNewsNo(int newsNo) throws SQLException {
		return (NewsSignVo)IbatisUtil.getSqlMap().queryForObject("getNewsSignByNewsNo", newsNo);
	}
	
	public void updateSign(NewsSignVo sign) throws SQLException {
		IbatisUtil.getSqlMap().update("updateSign", sign);
	}
}
