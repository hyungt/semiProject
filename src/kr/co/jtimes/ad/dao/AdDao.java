package kr.co.jtimes.ad.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.ad.vo.AdVo;
import kr.co.jtimes.common.criteria.AdCriteria;
import kr.co.jtimes.util.IbatisUtil;

public class AdDao {

	@SuppressWarnings("unchecked")
	public List<AdVo> getAdAll()throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getAdAll");
	}
	
	public void addAd(AdVo adVo) throws SQLException{
		IbatisUtil.getSqlMap().insert("addAd", adVo);
	}
	
	public AdVo getAdByNo(int no) throws SQLException{
		return (AdVo) IbatisUtil.getSqlMap().queryForObject("getAdByNo", no);
	}

	
	@SuppressWarnings("unchecked")
	public List<AdVo> getAdByCriteria(AdCriteria criteria) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getAdByCriteria", criteria);
	}

	
	@SuppressWarnings("unchecked")
	public List<AdVo> getAdByDate() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAdByDate");
	}

	@SuppressWarnings("unchecked")
	public List<AdVo> getAdDone(AdCriteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAdDone",criteria);
	}
	
	@SuppressWarnings("unchecked")
	public List<AdVo> getAdByIng(AdCriteria criteria) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getAdByIng", criteria);
	}
	
}
