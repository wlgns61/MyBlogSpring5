package com.myblog.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.myblog.board.model.BoardVO;
import com.myblog.board.model.ReplyVO;
import com.myblog.common.Search;


@Repository 
public class BoardDAOImpl implements BoardDAO{
	
	@Inject 
	private SqlSession sqlSession;

	@Override
	public List<BoardVO> getBoardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<BoardVO> session = sqlSession.selectList("com.myblog.board.boardMapper.getBoardList", search);
		return session;
	}

	@Override
	public BoardVO getBoardContent(int bid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("com.myblog.board.boardMapper.getBoardContent", bid);
	}

	@Override
	public int insertBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("com.myblog.board.boardMapper.insertBoard", boardVO); 
	}

	@Override
	public int updateBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("com.myblog.board.boardMapper.updateBoard", boardVO); 
	}

	@Override
	public int deleteBoard(int bid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("com.myblog.board.boardMapper.deleteBoard", bid); 
	}

	@Override
	public int updateViewCnt(int bid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("com.myblog.board.boardMapper.updateViewCnt", bid); 
	}
	
	@Override
	public int getBoardListCnt(Search search) throws Exception{
		return sqlSession.selectOne("com.myblog.board.boardMapper.getBoardListCnt", search);
	}
	
	//댓글 리스트
	@Override
	public List<ReplyVO> getReplyList(int bid) throws Exception{
		return sqlSession.selectList("com.myblog.board.replyMapper.getReplyList", bid); 
	}
	
	@Override
	public int saveReply(ReplyVO replyVO) throws Exception{
		return sqlSession.insert("com.myblog.board.replyMapper.saveReply", replyVO);
	}
	
	@Override
	public int updateReply(ReplyVO replyVO) throws Exception{
		return sqlSession.update("com.myblog.board.replyMapper.updateReply", replyVO);
	}
	
	@Override
	public int deleteReply(int rid) throws Exception{
		return sqlSession.delete("com.myblog.board.replyMapper.deleteReply", rid);
	}
	
}
