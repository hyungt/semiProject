package kr.co.jtimes.common.criteria;

import java.util.Date;
import java.util.List;

import kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo;

public class Criteria {
	
	private String tapId;
	private String categoryAll;
	private String categoryRemainder;
	private String titleAuthorCategory;
	private String searchWord;
	private String beginDate;
	private String endDate;
	private List<String> extension;
	private int beginIndex;
	private int endIndex;
	private int categoryNo;
	
	public Criteria() {}


	public Criteria(String tapId, String categoryAll, String categoryRemainder, String titleAuthorCategory,
			String searchWord, String beginDate, String endDate, List<String> extension, int beginIndex, int endIndex) {
		super();
		this.tapId = tapId;
		this.categoryAll = categoryAll;
		this.categoryRemainder = categoryRemainder;
		this.titleAuthorCategory = titleAuthorCategory;
		this.searchWord = searchWord;
		this.beginDate = beginDate;
		this.endDate = endDate;
		this.extension = extension;
		this.beginIndex = beginIndex;
		this.endIndex = endIndex;
	}

	public String getTapId() {
		return tapId;
	}



	public void setTapId(String tapId) {
		this.tapId = tapId;
	}



	public String getCategoryAll() {
		return categoryAll;
	}



	public void setCategoryAll(String categoryAll) {
		this.categoryAll = categoryAll;
	}



	public String getCategoryRemainder() {
		return categoryRemainder;
	}



	public void setCategoryRemainder(String categoryRemainder) {
		this.categoryRemainder = categoryRemainder;
	}



	public String getTitleAuthorCategory() {
		return titleAuthorCategory;
	}



	public void setTitleAuthorCategory(String titleAuthorCategory) {
		this.titleAuthorCategory = titleAuthorCategory;
	}



	public String getSearchWord() {
		return searchWord;
	}



	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}



	public String getBeginDate() {
		return beginDate;
	}



	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}



	public String getEndDate() {
		return endDate;
	}



	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}



	public List<String> getExtension() {
		return extension;
	}



	public void setExtension(List<String> extension) {
		this.extension = extension;
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



	@Override
	public String toString() {
		return "Criteria [tapId=" + tapId + ", categoryAll=" + categoryAll + ", categoryRemainder=" + categoryRemainder
				+ ", titleAuthorCategory=" + titleAuthorCategory + ", searchWord=" + searchWord + ", beginDate="
				+ beginDate + ", endDate=" + endDate + ", extension=" + extension + ", beginIndex=" + beginIndex
				+ ", endIndex=" + endIndex + "]";
	}


	public int getCategoryNo() {
		return categoryNo;
	}


	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}




	



	
	
	
	
	
	
	
	
}
