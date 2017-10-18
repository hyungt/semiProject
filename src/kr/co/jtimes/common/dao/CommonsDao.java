package kr.co.jtimes.common.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.common.vo.DepartmentVo;
import kr.co.jtimes.common.vo.NewsCategoryVo;
import kr.co.jtimes.common.vo.NewsTypeVo;
import kr.co.jtimes.common.vo.ReporterPositionVo;
import kr.co.jtimes.util.IbatisUtil;

public class CommonsDao {

	public List<NewsCategoryVo> getAllCategory() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAllCategory");
	}
	
	public List<NewsTypeVo> getAllNewsType() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAllNewsType");
	}
	
	public NewsCategoryVo getCategoryByNo(int categoryNo) throws SQLException {
		return (NewsCategoryVo)IbatisUtil.getSqlMap().queryForObject("getNewsCategoryDataByNo", categoryNo);
	}
	
	public NewsTypeVo getNewsTypeByNo(int typeNo) throws SQLException {
		return (NewsTypeVo)IbatisUtil.getSqlMap().queryForObject("getNewsTypeDataByNo", typeNo);
	}
	
	public List<ReporterPositionVo> getAllPosition() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAllPosition");
	}
	
	public List<DepartmentVo> getAllDepartment() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAllDepartment");
	}
}
