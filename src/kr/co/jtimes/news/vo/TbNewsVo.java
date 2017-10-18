package kr.co.jtimes.news.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import kr.co.jtimes.common.vo.NewsCategoryVo;
import kr.co.jtimes.common.vo.NewsTypeVo;
import kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo;
import kr.co.jtimes.util.DateUtils;

public class TbNewsVo {
	
	private int newsNo;
	private String newsLocation;
	private String newsTitle;
	private String newsContents;
	private Date regdate;
	private String newsImgPath;
	private int newsViewCnt;
	private String newsSignState;
	private NewsTypeVo newsType;
	private NewsCategoryVo category;
	private ReporterEmployeeVo reporter;
	

	
	public TbNewsVo() {}
	
	public TbNewsVo(int newsNo, String newsLocation, String newsTitle, String newsContents, Date regdate,
			String newsImgPath, int newsViewCnt, String newsSignState, NewsTypeVo newsTypeNo, NewsCategoryVo categoryNo,
			ReporterEmployeeVo reporterNo) {
		super();
		this.newsNo = newsNo;
		this.newsLocation = newsLocation;
		this.newsTitle = newsTitle;
		this.newsContents = newsContents;
		this.regdate = regdate;
		this.newsImgPath = newsImgPath;
		this.newsViewCnt = newsViewCnt;
		this.newsSignState = newsSignState;
		this.newsType = newsTypeNo;
		this.category = categoryNo;
		this.reporter = reporterNo;
	}

	public int getNewsNo() {
		return newsNo;
	}
	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public String getNewsLocation() {
		return newsLocation;
	}
	public void setNewsLocation(String newsLocation) {
		this.newsLocation = newsLocation;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public String getNewsContents() {
		return newsContents;
	}
	public void setNewsContents(String newsContents) {
		this.newsContents = newsContents;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getNewsImgPath() {
		return newsImgPath;
	}
	public void setNewsImgPath(String newsImgPath) {
		this.newsImgPath = newsImgPath;
	}
	public int getNewsViewCnt() {
		return newsViewCnt;
	}
	public void setNewsViewCnt(int newsViewCnt) {
		this.newsViewCnt = newsViewCnt;
	}
	public String getNewsSignState() {
		return newsSignState;
	}
	public void setNewsSignState(String newsSignState) {
		this.newsSignState = newsSignState;
	}

	public NewsTypeVo getNewsType() {
		return newsType;
	}

	public void setNewsType(NewsTypeVo newsType) {
		this.newsType = newsType;
	}

	public NewsCategoryVo getCategory() {
		return category;
	}

	public void setCategory(NewsCategoryVo category) {
		this.category = category;
	}

	public ReporterEmployeeVo getReporter() {
		return reporter;
	}

	public void setReporter(ReporterEmployeeVo reporter) {
		this.reporter = reporter;
	}

	public String getRegdateFormatYYMMDD() {
		return DateUtils.yyyymmdd(regdate);
	}
	
	public String getRegdateFormatYYMMDDHHMMSS() {
		return DateUtils.yyyymmddhhmmss(regdate);
	}
}
