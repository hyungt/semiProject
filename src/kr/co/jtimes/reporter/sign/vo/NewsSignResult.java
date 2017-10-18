package kr.co.jtimes.reporter.sign.vo;

import java.util.List;

public class NewsSignResult {
	private List<NewsSignVo> signList;
	private int totalNaviBlocks;
	private int currentNaviBlock;
	private int beginPage;
	private int endPage;
	private int totalPages;
	
	public List<NewsSignVo> getSignList() {
		return signList;
	}
	public void setSignList(List<NewsSignVo> signList) {
		this.signList = signList;
	}
	public int getTotalNaviBlocks() {
		return totalNaviBlocks;
	}
	public void setTotalNaviBlocks(int totalNaviBlocks) {
		this.totalNaviBlocks = totalNaviBlocks;
	}
	public int getCurrentNaviBlock() {
		return currentNaviBlock;
	}
	public void setCurrentNaviBlock(int currentNaviBlock) {
		this.currentNaviBlock = currentNaviBlock;
	}
	public int getBeginPage() {
		return beginPage;
	}
	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	
	
}
