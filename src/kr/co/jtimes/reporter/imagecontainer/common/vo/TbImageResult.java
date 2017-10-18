package kr.co.jtimes.reporter.imagecontainer.common.vo;

import java.util.List;


public class TbImageResult {

	private List<TbImageVo> imgList;
	private int totalNaviBlocks;
	private int currentNaviBlock;
	private int beginPage;
	private int endPage;
	private int totalPages;
	
	public List<TbImageVo> getImgList() {
		return imgList;
	}
	public void setImgList(List<TbImageVo> imgList) {
		this.imgList = imgList;
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
