package com.myblog.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myblog.user.model.UserVO;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	private UserDetailsService userService;
	
	@RequestMapping(value="/loginForm", method = RequestMethod.GET)
	public String loginForm(Model model) throws Exception {
		model.addAttribute("userVO", new UserVO());
		return "login/login";
	}
	
	
	@RequestMapping(value = "/signupForm", method = RequestMethod.GET) 
	public String signupForm(Model model) throws Exception { 
		model.addAttribute("userVO", new UserVO()); 
		return "login/signupForm"; 
	}
	
	/*
	@RequestMapping(value = "/doLogin", method = RequestMethod.POST) 
	public String doLogin(
			@ModelAttribute("userVO") UserVO userVO) throws Exception {
		System.out.println(userVO);
		//userService.loadUserByUsername(userVO.getUsername());
		return "board/getBoardList"; 
	}
	*/
}


