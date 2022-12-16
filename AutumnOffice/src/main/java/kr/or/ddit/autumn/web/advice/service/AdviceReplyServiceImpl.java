package kr.or.ddit.autumn.web.advice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.web.advice.dao.AdviceReplyDAO;
import kr.or.ddit.autumn.web.vo.AdviceReplyVO;

@Service
public class AdviceReplyServiceImpl implements AdviceReplyService {
	
	@Inject
	private AdviceReplyDAO replyDAO;
	
	@Override
	public List<AdviceReplyVO> adviceReplyList(int advNo) {
		return replyDAO.adviceReplyList(advNo);
	}

	@Override
	public int createReply(AdviceReplyVO replyVO) {
		return replyDAO.insertReply(replyVO);
	}

	@Override
	public int removeReply(AdviceReplyVO replyVO) {
		return replyDAO.deleteReply(replyVO);
	}

}
