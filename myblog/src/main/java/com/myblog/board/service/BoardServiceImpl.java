package com.myblog.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myblog.board.dao.BoardDAO;
import com.myblog.board.model.BoardVO;
import com.myblog.board.model.ReplyVO;
import com.myblog.common.Search;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	private BoardDAO boardDAO;
	
	@Override
	public List<BoardVO> getBoardList(Search search) throws Exception{
		return boardDAO.getBoardList(search);
	}
	
	@Override
	public void insertBoard(BoardVO boardVO) throws Exception{
		boardDAO.insertBoard(boardVO);
	}
	
	@Override
	public BoardVO getBoardContent(int bid) throws Exception{
		boardDAO.updateViewCnt(bid);
		return boardDAO.getBoardContent(bid);
	}
	
	@Override
	public void updateBoard(BoardVO boardVO) throws Exception{
		boardDAO.updateBoard(boardVO);
	}
	
	@Override 
	public void deleteBoard(int bid) throws Exception{
		boardDAO.deleteBoard(bid);
	}
	
	@Override
	public int getBoardListCnt(Search search) throws Exception {
		return boardDAO.getBoardListCnt(search);
	}
	
	  // 댓글 리스트
	@Override
	public List<ReplyVO> getReplyList(int bid) throws Exception{
		return boardDAO.getReplyList(bid);
	}
	
	@Override
	public int saveReply(ReplyVO replyVO) throws Exception{
		return boardDAO.saveReply(replyVO);
	}
	
	@Override
	public int updateReply(ReplyVO replyVO) throws Exception{
		return boardDAO.updateReply(replyVO);
	}
	
	@Override
	public int deleteReply(int rid) throws Exception{
		return boardDAO.deleteReply(rid);
	}

}
