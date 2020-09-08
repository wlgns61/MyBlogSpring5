package com.myblog.user.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myblog.common.Search;
import com.myblog.user.dao.UserDAO;
import com.myblog.user.model.UserVO;

@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	private UserDAO userDAO;

	@Override
	public List<UserVO> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUserList(search);
	}

	@Override
	public UserVO getUserInfo(String uid) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUserInfo(uid);
	}

	@Override
	public void insertUser(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		userDAO.insertUser(userVO);
	}

	@Override
	public void updateUser(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		userDAO.updateUser(userVO);
		
	}

	@Override
	public void deleteUser(String uid) throws Exception {
		// TODO Auto-generated method stub
		userDAO.deleteUser(uid);
	}
	
	@Override
	public int validateUser(String uid) throws Exception{
		return userDAO.validateUser(uid);
	}
	
	@Override
	public int getUserListCnt(Search search) throws Exception {
		return userDAO.getUserListCnt(search);
	}
	
	@Override
	public String loginUser(UserVO userVO) throws Exception{
		return userDAO.loginUser(userVO);
	}
	
}
