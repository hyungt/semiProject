package kr.co.jtimes.news.comment.vo;

import java.util.List;

import kr.co.jtimes.news.comment.Dao.CommentLikeDao;

public class ExpendResult {
	private List<NewCommentVo> commentList;
	private boolean continueExpand;
	
	public List<NewCommentVo> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<NewCommentVo> commentList) {
		this.commentList = commentList;
	}
	public boolean isContinueExpand() {
		return continueExpand;
	}
	public void setContinueExpand(boolean continueExpand) {
		this.continueExpand = continueExpand;
	}
}
