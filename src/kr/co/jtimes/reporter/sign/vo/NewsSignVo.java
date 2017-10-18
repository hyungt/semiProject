package kr.co.jtimes.reporter.sign.vo;

import kr.co.jtimes.news.vo.TbNewsVo;
import kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo;

public class NewsSignVo {

	private int no;
	private TbNewsVo news;
	private ReporterEmployeeVo writer;
	private ReporterEmployeeVo firstSigner;
	private ReporterEmployeeVo secondSigner;
	private String firstSignState;
	private String secondSignState;
	
	public ReporterEmployeeVo getWriter() {
		return writer;
	}
	public void setWriter(ReporterEmployeeVo writer) {
		this.writer = writer;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
	public TbNewsVo getNews() {
		return news;
	}
	public void setNews(TbNewsVo newsNo) {
		this.news = newsNo;
	}
	
	public ReporterEmployeeVo getFirstSigner() {
		return firstSigner;
	}
	public void setFirstSigner(ReporterEmployeeVo firstSigner) {
		this.firstSigner = firstSigner;
	}
	public ReporterEmployeeVo getSecondSigner() {
		return secondSigner;
	}
	public void setSecondSigner(ReporterEmployeeVo secondSigner) {
		this.secondSigner = secondSigner;
	}
	public String getFirstSignState() {
		return firstSignState;
	}
	public void setFirstSignState(String firstSignState) {
		this.firstSignState = firstSignState;
	}
	public String getSecondSignState() {
		return secondSignState;
	}
	public void setSecondSignState(String secondSignState) {
		this.secondSignState = secondSignState;
	}
}
