package kr.or.ddit.autumn.groupware.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CommentsVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface CommunicationDAO {
	public int insertPost(PostVO post);
	public PostVO selectPost(@Param("poNo") int poNo);
	public int incrementPoHit(@Param("poNo") int poNo);
	public int selectTotalRecord(PagingVO<PostVO> paging);
	public List<PostVO> selectPostList(PagingVO<PostVO> paging);
	public int updatePost(PostVO post);
	public int deletePost(PostVO post);
	
	public List<AttatchVO> selectAttatchList(PostVO post);
	public List<CommentsVO> selectCommentList(PostVO post);
	public PostVO selectCategory(@Param("empId") String empId);
	public int  deleteComment(PostVO post);
	
}
