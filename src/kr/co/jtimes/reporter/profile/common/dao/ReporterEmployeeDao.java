package kr.co.jtimes.reporter.profile.common.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.common.criteria.ReporterCriteria;
import kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo;
import kr.co.jtimes.util.IbatisUtil;

public class ReporterEmployeeDao {

	public ReporterEmployeeVo getReporterById (String reporterId) throws SQLException{
		return (ReporterEmployeeVo) IbatisUtil.getSqlMap().queryForObject("getReporterById", reporterId);
	}
	
	public void updateReporterAll(ReporterEmployeeVo reporterEmployeeVo) throws SQLException {
		IbatisUtil.getSqlMap().update("updateReporterAll",reporterEmployeeVo);
	}
	
	public void updateReporterPassword(ReporterEmployeeVo reporterEmployeeVo) throws SQLException{
		IbatisUtil.getSqlMap().update("updateReporterPassword", reporterEmployeeVo );
	}
	
	public void findPassword(ReporterEmployeeVo reporterEmployeeVo) throws SQLException{
		IbatisUtil.getSqlMap().update("findPassword", reporterEmployeeVo );
	}
	
	public ReporterEmployeeVo getEmailPwd(ReporterEmployeeVo reporterEmployeeVo) throws SQLException {
		return (ReporterEmployeeVo) IbatisUtil.getSqlMap().queryForObject("getEmailPwd", reporterEmployeeVo);
	}
	
	public List<ReporterEmployeeVo> getBossReportersByNo(int reporterNo) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getBossReportersByNo", reporterNo);
	}
	
	public List<ReporterEmployeeVo> getChiefs() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getChiefs");
	}
	public ReporterEmployeeVo getReporterByNo(int no) throws SQLException {
		return (ReporterEmployeeVo)IbatisUtil.getSqlMap().queryForObject("getReporterByNo", no);
	}
	
	public void addReporter(ReporterEmployeeVo reporterEmployeeVo)throws SQLException{
		IbatisUtil.getSqlMap().insert("addReporter",reporterEmployeeVo);
	}
	
	public List<ReporterEmployeeVo> getReporterAll(ReporterCriteria reporterCriteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getReporterAll", reporterCriteria);
	}
	
	public List<ReporterEmployeeVo> getReporterAllSearch(ReporterCriteria reporterCriteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getReporterAllSearch", reporterCriteria);
	}
	
	public void masterUpdate(ReporterEmployeeVo reporterEmployeeVo) throws SQLException{
			IbatisUtil.getSqlMap().update("masterUpdate", reporterEmployeeVo);
	}
	
	public int getTotalEmployeeRows() throws SQLException{
		return (int)IbatisUtil.getSqlMap().queryForObject("getTotalEmployeeRows");
	}
}
