package kr.or.ddit.autumn.groupware.board.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.CommentsVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface CommentService {
	public List<CommentsVO> retrieveCommentList(PagingVO<CommentsVO> pagingVO);
	public ServiceResult createComment(CommentsVO comment);
	public ServiceResult updateComment(CommentsVO comment);
	public ServiceResult deleteComment(CommentsVO comment);
}
