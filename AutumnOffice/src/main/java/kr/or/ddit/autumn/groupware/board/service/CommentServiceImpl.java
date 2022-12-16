package kr.or.ddit.autumn.groupware.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.board.dao.CommentDAO;
import kr.or.ddit.autumn.vo.CommentsVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService{

	private final CommentDAO commentDAO;
	
	@Override
	public List<CommentsVO> retrieveCommentList(PagingVO<CommentsVO> pagingVO) {
		// 페이징 처리시 필요
//		pagingVO.setTotalRecord(dao.selectTotalRecord(pagingVO));
		pagingVO.setDataList(commentDAO.selectCommentList(pagingVO));
		return pagingVO.getDataList();
	}

	@Override
	public ServiceResult createComment(CommentsVO comments) {
		return commentDAO.insertComment(comments) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult updateComment(CommentsVO comments) {
		return commentDAO.updateComment(comments) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult deleteComment(CommentsVO comments) {
		return commentDAO.deleteComment(comments) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}


}
