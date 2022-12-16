package kr.or.ddit.autumn.web.advice.service;

import java.util.List;

import kr.or.ddit.autumn.web.vo.AdviceReplyVO;

public interface AdviceReplyService {
	public List<AdviceReplyVO> adviceReplyList(int advNo);
	public int createReply(AdviceReplyVO replyVO);
	public int removeReply(AdviceReplyVO replyVO);
}
