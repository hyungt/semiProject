package kr.co.jtimes.citizenrep.comments.vo;

import java.util.Date;

import kr.co.jtimes.citizenrep.vo.CitizenRepVo;
import kr.co.jtimes.profile.common.vo.UserVo;

public class CrCommentsVo {

	private int no;
	private Date regDate;
	private CitizenRepVo citizenRepVo;
	private UserVo userVo;
	private String contents;
	public CrCommentsVo() {
		// TODO Auto-generated constructor stub
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public CitizenRepVo getCitizenRepVo() {
		return citizenRepVo;
	}
	public void setCitizenRepVo(CitizenRepVo citizenRepVo) {
		this.citizenRepVo = citizenRepVo;
	}
	public UserVo getUserVo() {
		return userVo;
	}
	public void setUserVo(UserVo userVo) {
		this.userVo = userVo;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	@Override
	public String toString() {
		return "CrCommentsVo [no=" + no + ", regDate=" + regDate + ", citizenRepVo=" + citizenRepVo + ", userVo="
				+ userVo + ", contents=" + contents + "]";
	}
}
