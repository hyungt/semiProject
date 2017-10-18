package kr.co.jtimes.news.vo;

import kr.co.jtimes.profile.common.vo.UserVo;

public class TbSuggestVo {

	private TbNewsVo tbNewsVo;
	private UserVo userNo;
	
	public TbSuggestVo() {}

	public TbSuggestVo(TbNewsVo tbNewsVo, UserVo userNo) {
		super();
		this.tbNewsVo = tbNewsVo;
		this.userNo = userNo;
	}

	public TbNewsVo getTbNewsVo() {
		return tbNewsVo;
	}

	public void setTbNewsVo(TbNewsVo tbNewsVo) {
		this.tbNewsVo = tbNewsVo;
	}

	public UserVo getUserNo() {
		return userNo;
	}

	public void setUserNo(UserVo userNo) {
		this.userNo = userNo;
	}

	@Override
	public String toString() {
		return "TbSuggest [tbNewsVo=" + tbNewsVo + ", userNo=" + userNo + "]";
	};
	
	
}
