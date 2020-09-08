package com.myblog.user.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.myblog.common.Search;
import com.myblog.user.model.UserVO;
import com.myblog.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "/getUserList", method=RequestMethod.GET) //post로 값을 요청받기 때문에 ajax코드로 post를 해야함!
	public String getUserList(Model model
			, @RequestParam(required = false, defaultValue="1") int page
			, @RequestParam(required = false, defaultValue="1") int range
			, @RequestParam(required = false, defaultValue="uid") String searchType
			, @RequestParam(required = false) String keyword
			, @ModelAttribute("search") Search search) throws Exception{
		
		model.addAttribute("search", search);
		search.setKeyword(keyword);
		search.setSearchType(searchType);
		
		int listCnt = userService.getUserListCnt(search); //전체 게시글, 검색된 항목의 수
		search.pageInfo(page, range, listCnt);
		
		model.addAttribute("pagination", search);
		model.addAttribute("boardList", userService.getUserList(search)); //뷰(jsp)에서 boardList로 받을수 있음
		
		List<UserVO> userList = userService.getUserList(search);
		model.addAttribute("userList", userList);
		
		return "user/userList";
	}
	
	@RequestMapping(value="/insertUser", method=RequestMethod.POST)
	public String insertUser(@ModelAttribute("userVO") UserVO userVO) throws Exception{
		userVO.setEnabled(true);
		userVO.setPwd("{noop}" + userVO.getPwd());
		userService.insertUser(userVO);
		return "login/login";
	}
	
	@RequestMapping(value="/updateUser", method=RequestMethod.POST)
	public String updateUser(Model model,
			Authentication authentication,
			@RequestParam(value="target", required=false) String target) throws Exception{
		UserVO nowUser = (UserVO) authentication.getPrincipal();
		if(nowUser.getAuthority().equals("ROLE_ADMIN")) {
			nowUser = userService.getUserInfo(target);
			model.addAttribute("nowUser", nowUser);
		}
		else {
			model.addAttribute("nowUser", nowUser);
		}
		return "user/pwdUpdateForm";
		
	}
	
	@RequestMapping(value="/updatePwd", method=RequestMethod.POST)
	public String updatePwd(Model model,
			@RequestParam("newpwd") String newpwd,
			@RequestParam("uid") String uid,
			Authentication authentication) throws Exception{
		UserVO nowUser = (UserVO) authentication.getPrincipal();
		if(nowUser.getAuthority().equals("ROLE_ADMIN")) {
			UserVO target = userService.getUserInfo(uid);
			target.setPwd("{noop}" + newpwd);
			userService.updateUser(target);
			return "redirect:/user/getUserList";
		}
		else {
			nowUser.setPwd("{noop}" + newpwd);
			userService.updateUser(nowUser);
			return "login/updateSuccess";
		}
	}
}
