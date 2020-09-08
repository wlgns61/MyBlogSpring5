package com.myblog.user.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.myblog.common.Search;
import com.myblog.user.model.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public List<UserVO> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<UserVO> session = sqlSession.selectList("com.myblog.user.userMapper.getUserList", search);
		return session;
	}
	
	@Override
	public int getUserListCnt(Search search) throws Exception{
		return sqlSession.selectOne("com.myblog.user.userMapper.getUserListCnt", search);
	}

	@Override
	public UserVO getUserInfo(String uid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("com.myblog.user.userMapper.getUserInfo", uid);
	}

	@Override
	public int insertUser(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("com.myblog.user.userMapper.insertUser", userVO);
	}

	@Override
	public int updateUser(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("com.myblog.user.userMapper.updateUser", userVO);
	}

	@Override
	public int deleteUser(String uid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("com.myblog.user.userMapper.deleteUser", uid);
	}
	
	@Override
	public int validateUser(String uid) throws Exception{
		return sqlSession.selectOne("com.myblog.user.userMapper.validateUser", uid);
	}
	
	@Override
	public String loginUser(UserVO userVO) throws Exception{
		return sqlSession.selectOne("com.myblog.user.userMapper.loginUser", userVO);
	}
	
}
