package com.myblog.user.service;

import javax.inject.Inject;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.myblog.user.dao.UserDAO;
import com.myblog.user.model.UserVO;

@Service
public class UserDetailsServiceImpl implements UserDetailsService{

	@Inject
	private UserDAO userDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UserVO userVO = new UserVO();
		try {
			userVO = userDAO.getUserInfo(username);
			if(userVO != null) {
				userVO.setAuthorities(AuthorityUtils.createAuthorityList(userVO.getAuthority()));
				System.out.println(userVO);
			}
			else {
				throw new UsernameNotFoundException(username);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userVO;
	}

}
