package kr.co.jtimes.common.vo;

public class NewsTypeVo {

	private int newsTypeNo;
	private String newsTypeName;
	
	public NewsTypeVo() {}
	
	public NewsTypeVo(int newsTypeNo, String newsTypeName) {
		super();
		this.newsTypeNo = newsTypeNo;
		this.newsTypeName = newsTypeName;
	}

	public int getNewsTypeNo() {
		return newsTypeNo;
	}
	public void setNewsTypeNo(int newsTypeNo) {
		this.newsTypeNo = newsTypeNo;
	}
	public String getNewsTypeName() {
		return newsTypeName;
	}
	public void setNewsTypeName(String newsTypeName) {
		this.newsTypeName = newsTypeName;
	}
	
	
}
