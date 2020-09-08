package com.myblog.menu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myblog.menu.model.MenuVO;
import com.myblog.menu.service.MenuService;

@RestController
@RequestMapping("/restMenu")
public class RestMenuController {
	
	private static final Logger logger = LoggerFactory.getLogger(RestMenuController.class);
	
	@Inject
	private MenuService menuService;
	
	@RequestMapping(value = "/getMenuList", method=RequestMethod.POST)
	public Map<String, Object> getMenuList(Model model) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		
		try { 
			List<MenuVO> menulist = menuService.getMenuList();
			result.put("menuList", menulist); 
			result.put("status", "OK"); 
		} 
		catch (Exception e) {
			result.put("status", "False"); 
			logger.info(e.getMessage()); 
		} 
		return result;
	}
	
	@RequestMapping(value = "/saveMenu", method=RequestMethod.POST)
	public Map<String, Object> saveMenu(MenuVO menuVO) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		System.out.println(menuVO.toString());
		
		logger.info("menuVO : " + menuVO.toString());
		
		try { 
			menuService.saveMenu(menuVO); 
			result.put("status", "OK"); 
		} 
		catch (Exception e) {
			result.put("status", "False"); 
			logger.info(e.getMessage()); 
		} 
		return result;
	}
	
	@RequestMapping(value = "/updateMenu", method=RequestMethod.POST)
	public Map<String, Object> updateMenu(MenuVO menuVO) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		
		try { 
			menuService.updateMenu(menuVO); 
			result.put("status", "OK"); 
		} 
		catch (Exception e) {
			result.put("status", "False"); 
			logger.info(e.getMessage()); 
		} 
		return result;
	}
	
	@RequestMapping(value = "/deleteMenu", method=RequestMethod.POST)
	public Map<String, Object> deleteMenu(@RequestParam("code") String code) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		
		try { 
			menuService.deleteMenu(code);  
			result.put("status", "OK"); 
		} 
		catch (Exception e) {
			result.put("status", "False"); 
			logger.info(e.getMessage()); 
		} 
		return result;
	}
}
