package kr.co.jtimes.reporter.profile.common.vo;

import kr.co.jtimes.common.vo.ReporterPositionVo;

public class ReporterEmployeeVo {

	private int reporterNo;
	private String reporterId;
	private String reporterName;
	private ReporterPositionVo reporterPos;
	private String reporterEmail;
	private String reporterPhone;
	private String reporterPw;
	private ReporterDeptVo deptNo;
	
	public ReporterEmployeeVo () {}

	public int getReporterNo() {
		return reporterNo;
	}

	public void setReporterNo(int reporterNo) {
		this.reporterNo = reporterNo;
	}

	public String getReporterId() {
		return reporterId;
	}

	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}

	public String getReporterName() {
		return reporterName;
	}

	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}

	public ReporterPositionVo getReporterPos() {
		return reporterPos;
	}

	public void setReporterPos(ReporterPositionVo reporterPos) {
		this.reporterPos = reporterPos;
	}

	public String getReporterEmail() {
		return reporterEmail;
	}

	public void setReporterEmail(String reporterEmail) {
		this.reporterEmail = reporterEmail;
	}

	public String getReporterPhone() {
		return reporterPhone;
	}

	public void setReporterPhone(String reporterPhone) {
		this.reporterPhone = reporterPhone;
	}

	public String getReporterPw() {
		return reporterPw;
	}

	public void setReporterPw(String reporterPw) {
		this.reporterPw = reporterPw;
	}

	public ReporterDeptVo getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(ReporterDeptVo deptNo) {
		this.deptNo = deptNo;
	}

	@Override
	public String toString() {
		return "ReporterEmployeeVo [reporterNo=" + reporterNo + ", reporterId=" + reporterId + ", reporterName="
				+ reporterName + ", reporterPos=" + reporterPos + ", reporterEmail=" + reporterEmail
				+ ", reporterPhone=" + reporterPhone + ", reporterPw=" + reporterPw + ", deptNo=" + deptNo + "]";
	}

	
	
	
}
