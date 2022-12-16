package kr.or.ddit.autumn.groupware.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.CommentsVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface CommentDAO {
	public List<CommentsVO> selectCommentList(PagingVO<CommentsVO> pagingVO);
	public int selectTotalRecord(PagingVO<CommentsVO> pagingVO);
	public int insertComment(CommentsVO comments);
	public int updateComment(CommentsVO comments);
	public int deleteComment(CommentsVO comments);
}
