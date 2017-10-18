package kr.co.jtimes.reporter.imagecontainer.common.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.common.criteria.Criteria;
import kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo;
import kr.co.jtimes.util.IbatisUtil;


public class TbImageDao {


	@SuppressWarnings("unchecked")
	public List<TbImageVo> getImageSelectAll() throws SQLException{
		
		return IbatisUtil.getSqlMap().queryForList("getImageSelectAll");
	}
	
	@SuppressWarnings("unchecked")
	public List<TbImageVo> getImageSelectAlterStateMain() throws SQLException{
		
		return IbatisUtil.getSqlMap().queryForList("getImageSelectAlterStateMain");
	}
	
	@SuppressWarnings("unchecked")
	public List<TbImageVo> getImageSelectAlterState(String btnId) throws SQLException{
		
		return IbatisUtil.getSqlMap().queryForList("getImageSelectAlterState", btnId);
	}
	

	@SuppressWarnings("unchecked")
	public List<TbImageVo> getExpendSelectImage(Criteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getExpendSelectImage", criteria);
	}
	

	public TbImageVo getImgByNo(int no) throws SQLException{
		
		return (TbImageVo) IbatisUtil.getSqlMap().queryForObject("getImgByNo", no);
	}

	
	public void addtbImageVo(TbImageVo tbImageVo) throws SQLException{
		IbatisUtil.getSqlMap().insert("addtbImageVo", tbImageVo);
	}
	
	@SuppressWarnings("unchecked")
	public List<TbImageVo> getSearchBySelectSort(Criteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getSearchBySelectSort", criteria);
	}
	
	public int getImageTotalRows(Criteria criteria) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getImageTotalRows", criteria);
	}
}
	
