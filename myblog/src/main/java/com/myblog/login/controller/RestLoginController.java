package com.myblog.login.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myblog.user.service.UserService;

@RestController
@RequestMapping("/restLogin")
public class RestLoginController {
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "/userValidate", method = RequestMethod.POST) 
	public int userValidate(@RequestParam("uid") String uid) throws Exception {
		int result = userService.validateUser(uid);
		return result;
	}
	
	/*
	@RequestMapping(value = "/login", method=RequestMethod.POST)
	public String login(
			@RequestParam("uid") String uid, 
			@RequestParam("pwd") String pwd, 
			HttpSession session) throws Exception{
		
		UserVO userVO = new UserVO();
		userVO.setUid(uid);
		userVO.setPwd(pwd);
		
		String uidResult = userService.loginUser(userVO);
		
		if(uidResult != null) {
			session.setAttribute("loginStatus", true);
			session.setAttribute("loginId", uidResult);
			return uidResult;
		}
		else {
			return "";
		}
		
	}
	*/
}
