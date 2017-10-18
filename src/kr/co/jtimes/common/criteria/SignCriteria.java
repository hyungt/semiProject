package kr.co.jtimes.common.criteria;

public class SignCriteria {
	private String state;
	private int signerNo;
	private int beginIndex;
	private int endIndex;
	private int writerNo;
	
	public int getWriterNo() {
		return writerNo;
	}
	public void setWriterNo(int writerNo) {
		this.writerNo = writerNo;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public int getSignerNo() {
		return signerNo;
	}
	public void setSignerNo(int signerNo) {
		this.signerNo = signerNo;
	}
	
	public int getBeginIndex() {
		return beginIndex;
	}
	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}
	
	public int getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}
	
}
