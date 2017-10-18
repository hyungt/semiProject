package kr.co.jtimes.common.criteria;

import java.sql.Date;

public class AdCriteria {

	private int beginIndex;
	private int endIndex;
	private int page;
	private int adNo;
	private String adImgPath;
	private String adTitle;
	private String adLink;
	private Date adStartDate;
	private Date adEndDate;
	private int searchRanger = 20;
	private String type;
	
	public AdCriteria(){}


	public AdCriteria(int beginIndex, int endIndex, int page, int adNo, String adImgPath, String adTitle, String adLink,
			Date adStartDate, Date adEndDate, String type) {
		super();
		this.beginIndex = beginIndex;
		this.endIndex = endIndex;
		this.page = page;
		this.adNo = adNo;
		this.adImgPath = adImgPath;
		this.adTitle = adTitle;
		this.adLink = adLink;
		this.adStartDate = adStartDate;
		this.adEndDate = adEndDate;
		this.type = type;
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


	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		this.page = page;
		this.beginIndex = ((page - 1) * searchRanger) + 1;
		this.endIndex = page * searchRanger;
	}


	public int getAdNo() {
		return adNo;
	}


	public void setAdNo(int adNo) {
		this.adNo = adNo;
	}


	public String getAdImgPath() {
		return adImgPath;
	}


	public void setAdImgPath(String adImgPath) {
		this.adImgPath = adImgPath;
	}


	public String getAdTitle() {
		return adTitle;
	}


	public void setAdTitle(String adTitle) {
		this.adTitle = adTitle;
	}


	public String getAdLink() {
		return adLink;
	}


	public void setAdLink(String adLink) {
		this.adLink = adLink;
	}


	public Date getAdStartDate() {
		return adStartDate;
	}


	public void setAdStartDate(Date adStartDate) {
		this.adStartDate = adStartDate;
	}


	public Date getAdEndDate() {
		return adEndDate;
	}


	public void setAdEndDate(Date adEndDate) {
		this.adEndDate = adEndDate;
	}

	

	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	@Override
	public String toString() {
		return "AdCriteria [beginIndex=" + beginIndex + ", endIndex=" + endIndex + ", page=" + page + ", adNo=" + adNo
				+ ", adImgPath=" + adImgPath + ", adTitle=" + adTitle + ", adLink=" + adLink + ", adStartDate="
				+ adStartDate + ", adEndDate=" + adEndDate + ", type=" + type + "]";
	}

	
	
}
