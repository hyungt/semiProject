package kr.co.jtimes.citizenrep.vo;

import java.util.Date;

import kr.co.jtimes.profile.common.vo.UserVo;

public class CitizenRepVo {

	private int citizenRepNo;
	private String citizenRepTitle;
	private String citizenRepContents;
	private Date citizenRepCreateDate;
	private UserVo writer;
	public CitizenRepVo() {
		// TODO Auto-generated constructor stub
	}
	public int getCitizenRepNo() {
		return citizenRepNo;
	}
	public void setCitizenRepNo(int citizenRepNo) {
		this.citizenRepNo = citizenRepNo;
	}
	public String getCitizenRepTitle() {
		return citizenRepTitle;
	}
	public void setCitizenRepTitle(String citizenRepTitle) {
		this.citizenRepTitle = citizenRepTitle;
	}
	public String getCitizenRepContents() {
		return citizenRepContents;
	}
	public void setCitizenRepContents(String citizenRepContents) {
		this.citizenRepContents = citizenRepContents;
	}
	public Date getCitizenRepCreateDate() {
		return citizenRepCreateDate;
	}
	public void setCitizenRepCreateDate(Date citizenRepCreateDate) {
		this.citizenRepCreateDate = citizenRepCreateDate;
	}
	public String getContentsWithBr(){
		return citizenRepContents.replace(System.lineSeparator(), "<br/>");
	}
	public UserVo getWriter() {
		return writer;
	}
	public void setWriter(UserVo writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "CitizenRepVo [citizenRepNo=" + citizenRepNo + ", citizenRepTitle=" + citizenRepTitle
				+ ", citizenRepContents=" + citizenRepContents + ", citizenRepCreateDate=" + citizenRepCreateDate
				+ ", writer=" + writer + "]";
	}
}
