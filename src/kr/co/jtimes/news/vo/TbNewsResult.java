package kr.co.jtimes.news.vo;

import java.util.List;

public class TbNewsResult {

	private List<TbNewsVo> newsList;
	private int totalNaviBlocks;
	private int currentNaviBlock;
	private int beginPage;
	private int endPage;
	private int newsCategory;
	private int totalPages;
	
	
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getNewsCategory() {
		return newsCategory;
	}
	public void setNewsCategory(int newsCategory) {
		this.newsCategory = newsCategory;
	}
	public List<TbNewsVo> getNewsList() {
		return newsList;
	}
	public void setNewsList(List<TbNewsVo> newsList) {
		this.newsList = newsList;
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
	
	
}
