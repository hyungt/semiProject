package kr.co.jtimes.reporter.imagecontainer.common.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import kr.co.jtimes.common.vo.NewsCategoryVo;
import kr.co.jtimes.common.vo.NewsTypeVo;
import kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo;

public class TbImageVo {

	private int imgNo;
	private String imgLocation;
	private String imgTitle;
	private String imgAlt;
	private String imgPath;
	private String imgAlterState;
	private ReporterEmployeeVo reporter;
	private NewsTypeVo newsType;
	private NewsCategoryVo category;
	private Date imgRegdate;
	private String imgType;
	private String imgSize;
	
	public TbImageVo() {}

	public TbImageVo(int imgNo, String imgLocation, String imgTitle, String imgAlt, String imgPath,
			String imgAlterState, ReporterEmployeeVo reporterNo, NewsTypeVo newsTypeNo, NewsCategoryVo categoryNo,
			Date imgRegdate, String imgType, String imgSize) {
		super();
		this.imgNo = imgNo;
		this.imgLocation = imgLocation;
		this.imgTitle = imgTitle;
		this.imgAlt = imgAlt;
		this.imgPath = imgPath;
		this.imgAlterState = imgAlterState;
		this.reporter = reporterNo;
		this.newsType = newsTypeNo;
		this.category = categoryNo;
		this.imgRegdate = imgRegdate;
		this.imgType = imgType;
		this.imgSize = imgSize;
	}

	public int getImgNo() {
		return imgNo;
	}

	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}

	public String getImgLocation() {
		return imgLocation;
	}

	public void setImgLocation(String imgLocation) {
		this.imgLocation = imgLocation;
	}

	public String getImgTitle() {
		return imgTitle;
	}

	public void setImgTitle(String imgTitle) {
		this.imgTitle = imgTitle;
	}

	public String getImgAlt() {
		return imgAlt;
	}

	public void setImgAlt(String imgAlt) {
		this.imgAlt = imgAlt;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getImgAlterState() {
		return imgAlterState;
	}

	public void setImgAlterState(String imgAlterState) {
		this.imgAlterState = imgAlterState;
	}

	public ReporterEmployeeVo getReporter() {
		return reporter;
	}

	public void setReporter(ReporterEmployeeVo reporter) {
		this.reporter = reporter;
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

	public Date getImgRegdate() {
		return imgRegdate;
	}

	public void setImgRegdate(Date imgRegdate) {
		this.imgRegdate = imgRegdate;
	}

	public String getImgType() {
		return imgType;
	}

	public void setImgType(String imgType) {
		this.imgType = imgType;
	}

	public String getImgSize() {
		return imgSize;
	}

	public void setImgSize(String imgSize) {
		this.imgSize = imgSize;
	}

	@Override
	public String toString() {
		return "TbImageVo [imgNo=" + imgNo + ", imgLocation=" + imgLocation + ", imgTitle=" + imgTitle + ", imgAlt="
				+ imgAlt + ", imgPath=" + imgPath + ", imgAlterState=" + imgAlterState + ", reporter=" + reporter
				+ ", newsType=" + newsType + ", category=" + category + ", imgRegdate=" + imgRegdate + ", imgType="
				+ imgType + ", imgSize=" + imgSize + "]";
	}

	
}
