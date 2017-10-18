package kr.co.jtimes.profile.common.dao;

import java.sql.SQLException;
import java.util.List;

import kr.co.jtimes.profile.common.vo.UserVo;
import kr.co.jtimes.util.IbatisUtil;

public class UserDao {

	public void addUser(UserVo user) throws SQLException {
		IbatisUtil.getSqlMap().insert("addUser",user);
	}
	
	public UserVo getUserById(String userid) throws SQLException {
		return (UserVo) IbatisUtil.getSqlMap().queryForObject("getUserById", userid);
	}
	
	@SuppressWarnings("unchecked")
	public List<UserVo> getUserAll() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getUserAll");
	}
	
	public UserVo getLoginId(UserVo findid) throws SQLException {
		return (UserVo)IbatisUtil.getSqlMap().queryForObject("getLoginId", findid);
	}
	
	public UserVo getLoginPwd(UserVo findpwd) throws SQLException {
		return (UserVo)IbatisUtil.getSqlMap().queryForObject("getLoginPwd", findpwd);
	}
	
	public void updatePwd(UserVo updatePwd) throws SQLException {
		IbatisUtil.getSqlMap().update("updatePwd", updatePwd);
	}
	
	public UserVo loginUser(UserVo idAndPwd) throws SQLException {
		return (UserVo)IbatisUtil.getSqlMap().queryForObject("loginUser", idAndPwd);
	}
	
	public void profileFix(UserVo fix) throws SQLException {
		IbatisUtil.getSqlMap().update("profileFix", fix);
	}
}
