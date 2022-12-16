package kr.or.ddit.autumn.groupware.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

/**
 * 커뮤니티 게시판 관리
 *
 */
public interface CommunicationService {
	public ServiceResult createPost(PostVO post);
	public PostVO retrievePost(int poNo);
	public PostVO retrievePostForEdit(int poNo);
	public List<PostVO> retrievePostList(PagingVO<PostVO> paging);
	public int retrievePostCount(PagingVO<PostVO> paging);
	public ServiceResult modifyPost(PostVO post);
	public ServiceResult removePost(PostVO post);
	public AttatchVO retrieveAttatch(@Param("attNo") int attNo);
	
}
