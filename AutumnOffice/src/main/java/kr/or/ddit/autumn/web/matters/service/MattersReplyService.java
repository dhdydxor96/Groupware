package kr.or.ddit.autumn.web.matters.service;

import java.util.List;

import kr.or.ddit.autumn.web.vo.MattersReplyVO;

public interface MattersReplyService {
	public List<MattersReplyVO> mattersReplyList(int matNo) ;
	public int createReply(MattersReplyVO replyVO) ;
	public int removeReply(MattersReplyVO replyVO);
}
