package kr.co.jtimes.ad.vo;

import java.util.Date;

import kr.co.jtimes.util.DateUtils;

public class AdVo {

	private int adNo;
	private String adTitle;
	private String adImgPath;
	private String adLink;
	private Date adStartDate;
	private Date adEndDate;
	private String formatStartDate;
	private String formatEndDate;
	
	public AdVo(){}

	public int getAdNo() {
		return adNo;
	}

	public void setAdNo(int adNo) {
		this.adNo = adNo;
	}

	public String getAdTitle() {
		return adTitle;
	}

	public void setAdTitle(String adTitle) {
		this.adTitle = adTitle;
	}

	public String getAdImgPath() {
		return adImgPath;
	}

	public void setAdImgPath(String adImgPath) {
		this.adImgPath = adImgPath;
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
		this.formatStartDate = DateUtils.yyyymmdd(this.adStartDate);
	}

	public Date getAdEndDate() {
		return adEndDate;
	}

	public void setAdEndDate(Date adEndDate) {
		this.adEndDate = adEndDate;
		this.formatEndDate = DateUtils.yyyymmdd(this.adEndDate);
	}

	@Override
	public String toString() {
		return "AdVo [adNo=" + adNo + ", adTitle=" + adTitle + ", adImgPath=" + adImgPath + ", adLink=" + adLink
				+ ", adStartDate=" + adStartDate + ", adEndDate=" + adEndDate + "]";
	}

		
}
