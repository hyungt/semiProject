package kr.co.jtimes.news.dao;

import java.sql.SQLException;
import kr.co.jtimes.news.vo.TbSuggestVo;
import kr.co.jtimes.util.IbatisUtil;

public class TbSuggestDao {

	public void addSuggest(TbSuggestVo suggest) throws SQLException {
		IbatisUtil.getSqlMap().insert("addSuggest", suggest);
	}
	public int getSuggests(int newNo) throws SQLException {
		return (Integer) IbatisUtil.getSqlMap().queryForObject("getSuggests", newNo);
	}
}
