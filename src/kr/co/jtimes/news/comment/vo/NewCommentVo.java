package kr.co.jtimes.news.comment.vo;

import java.util.Date;
import kr.co.jtimes.news.vo.TbNewsVo;
import kr.co.jtimes.profile.common.vo.UserVo;
import kr.co.jtimes.util.DateUtils;

public class NewCommentVo {

	private int commentNo;
	private Date commentRegDate;
	private TbNewsVo tbNewsVo;
	private UserVo userVo;
	private String commentContents;
	private int likeCnt;
	private int disLikeCnt;
	
	public NewCommentVo() {}

	public NewCommentVo(int commentNo, Date commentRegDate, TbNewsVo tbNewsVo, UserVo userVo, String commentContents) {
		super();
		this.commentNo = commentNo;
		this.commentRegDate = commentRegDate;
		this.tbNewsVo = tbNewsVo;
		this.userVo = userVo;
		this.commentContents = commentContents;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public Date getCommentRegDate() {
		return commentRegDate;
	}
	

	public void setCommentRegDate(Date commentRegDate) {
		this.commentRegDate = commentRegDate;
	}

	public TbNewsVo getTbNewsVo() {
		return tbNewsVo;
	}

	public void setTbNewsVo(TbNewsVo tbNewsVo) {
		this.tbNewsVo = tbNewsVo;
	}

	public UserVo getUserVo() {
		return userVo;
	}

	public void setUserVo(UserVo userVo) {
		this.userVo = userVo;
	}

	public String getCommentContents() {
		return commentContents;
	}

	public void setCommentContents(String commentContents) {
		this.commentContents = commentContents;
	}

	public String getRegdateFormatYYMMDD() {
		return DateUtils.yyyymmdd(commentRegDate);
	}
	
	public String getRegdateFormatYYMMDDHHMMSS() {
		return DateUtils.yyyymmddhhmmss(commentRegDate);
	}
	
	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public int getDisLikeCnt() {
		return disLikeCnt;
	}

	public void setDisLikeCnt(int disLikeCnt) {
		this.disLikeCnt = disLikeCnt;
	}

	@Override
	public String toString() {
		return "NewCommentVo [commentNo=" + commentNo + ", commentRegDate=" + commentRegDate + ", tbNewsVo=" + tbNewsVo
				+ ", userVo=" + userVo + ", commentContents=" + commentContents + "]";
	}

	
}
