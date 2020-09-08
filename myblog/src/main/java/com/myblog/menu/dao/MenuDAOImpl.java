package com.myblog.menu.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.myblog.menu.model.MenuVO;

@Repository
public class MenuDAOImpl implements MenuDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<MenuVO> getMenuList() throws Exception{
		return sqlSession.selectList("com.myblog.menu.menuMapper.getMenuList");
	}
	
	@Override
	public int saveMenu(MenuVO menuVO) throws Exception{
		return sqlSession.insert("com.myblog.menu.menuMapper.insertMenu", menuVO);
	}
	
	@Override
	public int updateMenu(MenuVO menuVO) throws Exception{
		return sqlSession.update("com.myblog.menu.menuMapper.updateMenu", menuVO);
	}
	
	@Override
	public int deleteMenu(String code) throws Exception{
		return sqlSession.delete("com.myblog.menu.menuMapper.deleteMenu", code);
	}
	
}
