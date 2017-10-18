package kr.co.jtimes.common.vo;

public class NewsCategoryVo {
	
	private int categoryNo;
	private String categoryName;
	
	public NewsCategoryVo() {}
	
	public NewsCategoryVo(int categoryNo, String categoryName) {
		super();
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
}
