package kr.co.jtimes.news.comment.Dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.common.criteria.CommentCriteria;
import kr.co.jtimes.news.comment.vo.NewCommentVo;
import kr.co.jtimes.util.IbatisUtil;

public class CommentDao {

	public void addComment(NewCommentVo newCommentVo) throws SQLException {
		IbatisUtil.getSqlMap().insert("addComment", newCommentVo);
	}
	
	@SuppressWarnings("unchecked")
	public List<NewCommentVo> getCommentByNewsNo(CommentCriteria criteria) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getCommentByNewsNo", criteria);
	}
	
	public int getTotalCommentRows(int newsNo) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getTotalCommentRows", newsNo);
	}
}
