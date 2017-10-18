package kr.co.jtimes.citizenrep.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.citizenrep.vo.CitizenRepVo;
import kr.co.jtimes.common.criteria.Criteria;
import kr.co.jtimes.util.IbatisUtil;

public class CitizenRepDao {

	public void addCitizenRep(CitizenRepVo citizenRepVo) throws SQLException{
		IbatisUtil.getSqlMap().insert("addCitizenRep", citizenRepVo);
	}
	
	@SuppressWarnings("unchecked")
	public List<CitizenRepVo> getAllCitRepNoMaster() throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getAllCitRep");
	}
	
	@SuppressWarnings("unchecked")
	public List<CitizenRepVo> getAllCitRepMaster() throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getAllCitRepMaster");
	}
	
	public CitizenRepVo getCitRepByNo(int no) throws SQLException{
		return (CitizenRepVo) IbatisUtil.getSqlMap().queryForObject("getCitRepByNo", no);
	}
	
	public void deleteCitRep(int no) throws SQLException{
		IbatisUtil.getSqlMap().update("deleteCitRep", no);
	}
	
	public CitizenRepVo getCitRepNoByTitle(String title) throws SQLException{
		return (CitizenRepVo) IbatisUtil.getSqlMap().queryForObject("getCitRepNoByTitle", title);
	}
	
	public void editCitRep(CitizenRepVo citizenRepVo) throws SQLException{
		IbatisUtil.getSqlMap().update("editCitRep", citizenRepVo);
	}

	public int getTotalRows() throws SQLException{
		return (int) IbatisUtil.getSqlMap().queryForObject("getTotalRows");
	}
	
	public List<CitizenRepVo> getCitReps(Criteria criteria) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getCitReps", criteria);
	}
	
	
}
