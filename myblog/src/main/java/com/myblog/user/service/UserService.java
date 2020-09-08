package com.myblog.user.service;

import java.util.List;

import com.myblog.common.Search;
import com.myblog.user.model.UserVO;

public interface UserService {
	
	public List<UserVO> getUserList(Search search) throws Exception;
	
	public UserVO getUserInfo(String uid) throws Exception;
	
	public void insertUser(UserVO userVO) throws Exception;
	
	public void updateUser(UserVO userVO) throws Exception;
	
	public void deleteUser(String uid) throws Exception;
	
	public int validateUser(String uid) throws Exception;
	
	public String loginUser(UserVO userVO) throws Exception;
	
	public int getUserListCnt(Search search) throws Exception;
}
