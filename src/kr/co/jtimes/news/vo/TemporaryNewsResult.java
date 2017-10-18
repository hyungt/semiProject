package kr.co.jtimes.news.vo;

import java.util.List;

public class TemporaryNewsResult {

	private List<TemporaryNewsVo> tempList;
	private TemporaryNewsVo temp;
	private String processType;
	
	public TemporaryNewsVo getTemp() {
		return temp;
	}
	public void setTemp(TemporaryNewsVo temp) {
		this.temp = temp;
	}
	public List<TemporaryNewsVo> getTempList() {
		return tempList;
	}
	public void setTempList(List<TemporaryNewsVo> tempList) {
		this.tempList = tempList;
	}
	public String getProcessType() {
		return processType;
	}
	public void setProcessType(String processType) {
		this.processType = processType;
	}
	
}
