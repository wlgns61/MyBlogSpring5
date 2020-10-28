package com.myblog.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myblog.board.model.BoardVO;
import com.myblog.board.model.ReplyVO;
import com.myblog.board.service.BoardService;
import com.myblog.common.Search;
import com.myblog.menu.service.MenuService;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
	@Inject
	private BoardService boardService;
	
	@Inject
	private MenuService menuService;
	
	@RequestMapping(value = "/getBoardList", method = RequestMethod.GET) 
	public String getBoardList(Model model
			, @RequestParam(required = false, defaultValue="1") int page
			, @RequestParam(required = false, defaultValue="1") int range
			, @RequestParam(required = false, defaultValue="title") String searchType
			, @RequestParam(required = false) String keyword
			, @RequestParam(required = false, defaultValue="all") String category
			, @ModelAttribute("search") Search search) throws Exception{
		
		search.setKeyword(keyword);
		search.setSearchType(searchType);
		search.setCategory(category);
		
		int listCnt = boardService.getBoardListCnt(search); //전체 게시글, 검색된 항목의 수
		search.pageInfo(page, range, listCnt);
		
		model.addAttribute("pagination", search);
		model.addAttribute("boardList", boardService.getBoardList(search)); //뷰(jsp)에서 boardList로 받을수 있음
		model.addAttribute("menuList", menuService.getMenuList());
		model.addAttribute("category", category);
		model.addAttribute("searchType", searchType);
		return "board/index";
	}
	
	@RequestMapping("/boardForm") //action
	public String boardForm(Model model) throws Exception{
		model.addAttribute("boardVO", new BoardVO());
		model.addAttribute("menuList", menuService.getMenuList());
		return "board/boardForm"; //view
	}
	
	@RequestMapping(value = "/saveBoard", method = RequestMethod.POST) // (view -> server)
	public String saveBoard(@ModelAttribute("BoardVO") BoardVO boardVO, @RequestParam("mode") String mode
			, RedirectAttributes rttr) throws Exception { // @ModelAttribute("BoardVO")는 뷰에서 이름이 "BoardVO"인 녀석
		try {
			if(mode.equals("edit")) {
				boardService.updateBoard(boardVO);
			}
			else {
				boardService.insertBoard(boardVO);
			}
		}catch(Exception e) {
			return "redirect:/board/getBoardList";
		}
		return "redirect:/board/getBoardList";
	}
	
	@RequestMapping(value = "/getBoardContent", method = RequestMethod.GET)
	@Transactional
	public String getBoardContent(Model model
			, @RequestParam("bid") int bid) throws Exception{
		BoardVO boardVO = new BoardVO();
		boardVO = boardService.getBoardContent(bid);
		model.addAttribute("boardContent", boardVO);
		model.addAttribute("replyVO", new ReplyVO());
		return "board/boardContent";
	}
	
	@RequestMapping(value = "/editForm", method = RequestMethod.GET)
	public String editForm(Model model, @RequestParam("bid") int bid
			, @RequestParam("mode") String mode) throws Exception{
		
		BoardVO boardVO = new BoardVO();
		boardVO = boardService.getBoardContent(bid);
		model.addAttribute("boardContent", boardVO);
		model.addAttribute("mode", mode);
		model.addAttribute("boardVO", new BoardVO());
		model.addAttribute("menuList", menuService.getMenuList());
		return "board/boardForm";
	}
	
	@RequestMapping(value = "/deleteBoard", method = RequestMethod.GET)
	public String deleteBoard(@RequestParam("bid") int bid) throws Exception{
		boardService.deleteBoard(bid);
		return "redirect:/board/getBoardList";
	}
	

}
