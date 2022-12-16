package kr.or.ddit.autumn.web.matters.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.web.matters.dao.MattersReplyDAO;
import kr.or.ddit.autumn.web.vo.MattersReplyVO;

@Service
public class MattersReplyServiceImpl implements MattersReplyService {
	
	@Inject
	private MattersReplyDAO replyDAO;

	@Override
	public List<MattersReplyVO> mattersReplyList(int matNo) {
		return replyDAO.mattersReplyList(matNo);
	}

	@Override
	public int createReply(MattersReplyVO replyVO) {
		return replyDAO.insertReply(replyVO);
	}

	@Override
	public int removeReply(MattersReplyVO replyVO) {
		return replyDAO.deleteReply(replyVO);
	}



	

}
