package kr.co.jtimes.reporter.profile.common.vo;

public class ReporterDeptVo {

	private int deptNo;
	private String deptName;
	
	public ReporterDeptVo () {}

	public int getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	@Override
	public String toString() {
		return "ReporterDept [deptNo=" + deptNo + ", deptName=" + deptName + "]";
	};
	
	
}
