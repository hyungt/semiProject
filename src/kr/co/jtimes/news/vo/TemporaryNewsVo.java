package kr.co.jtimes.news.vo;

import kr.co.jtimes.common.vo.NewsCategoryVo;
import kr.co.jtimes.common.vo.NewsTypeVo;
import kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo;

public class TemporaryNewsVo {
	
	private int no;
	private String location;
	private String title;
	private String contents;
	private String imgPath;
	private NewsTypeVo type;
	private NewsCategoryVo category;
	private ReporterEmployeeVo reporter;
	private String visible;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public NewsTypeVo getType() {
		return type;
	}
	public void setType(NewsTypeVo type) {
		this.type = type;
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
	public String getVisible() {
		return visible;
	}
	public void setVisible(String visible) {
		this.visible = visible;
	}
		
}
