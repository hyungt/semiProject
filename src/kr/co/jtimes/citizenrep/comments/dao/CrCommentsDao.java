package kr.co.jtimes.citizenrep.comments.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.citizenrep.comments.vo.CrCommentsVo;
import kr.co.jtimes.util.IbatisUtil;

public class CrCommentsDao {

	public void addCrComment(CrCommentsVo commentsVo) throws SQLException{
		IbatisUtil.getSqlMap().insert("addCrComment", commentsVo);
	}
	
	@SuppressWarnings("unchecked")
	public List<CrCommentsVo> getAllCommentByCrNo(int no) throws SQLException{
		return IbatisUtil.getSqlMap().queryForList("getAllCommentByCrNo", no);
	}
	
	public void deleteComment(int no) throws SQLException{
		IbatisUtil.getSqlMap().update("deleteComment", no);
	}
}
