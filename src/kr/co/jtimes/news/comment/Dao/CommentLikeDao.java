package kr.co.jtimes.news.comment.Dao;

import java.sql.SQLException;

import kr.co.jtimes.news.comment.vo.CommentLikeVo;
import kr.co.jtimes.util.IbatisUtil;

public class CommentLikeDao {

	public void addCommentLike(CommentLikeVo commentLike) throws SQLException {
		IbatisUtil.getSqlMap().insert("addCommentLike", commentLike);
	}
	
	public int getCommentLikeByCommentNo(int cno, String pref) throws SQLException {
		CommentLikeVo commentLike = new CommentLikeVo();
		commentLike.setPreference(pref);
		commentLike.setCno(cno);
		return (Integer) IbatisUtil.getSqlMap().queryForObject("getCommentLikeByCommentNo", commentLike);
	}
}
