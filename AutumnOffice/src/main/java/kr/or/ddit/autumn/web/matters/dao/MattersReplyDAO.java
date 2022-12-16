package kr.or.ddit.autumn.web.matters.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.web.vo.MattersReplyVO;

@Mapper
public interface MattersReplyDAO {
	public List<MattersReplyVO> mattersReplyList(int matNo) ;
	public int insertReply(MattersReplyVO replyVO) ;
	public int deleteReply(MattersReplyVO replyVO);
}
