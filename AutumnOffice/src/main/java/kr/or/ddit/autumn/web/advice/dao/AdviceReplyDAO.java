package kr.or.ddit.autumn.web.advice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.web.vo.AdviceReplyVO;

@Mapper
public interface AdviceReplyDAO {
	public List<AdviceReplyVO> adviceReplyList(int advNo);
	public int insertReply(AdviceReplyVO replyVO);
	public int deleteReply(AdviceReplyVO replyVO);
}
