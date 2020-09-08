package com.myblog.user.dao;

import java.util.List;

import com.myblog.common.Search;
import com.myblog.user.model.UserVO;

public interface UserDAO {
	
	public List<UserVO> getUserList(Search search) throws Exception; 
	
	public UserVO getUserInfo(String uid) throws Exception;
	
	public int insertUser(UserVO userVO) throws Exception;
	
	public int updateUser(UserVO userVO) throws Exception;
	
	public int deleteUser(String uid) throws Exception;
	
	public int validateUser(String uid) throws Exception;
	
	public String loginUser(UserVO userVO) throws Exception;
	
	public int getUserListCnt(Search search) throws Exception;
	
}
