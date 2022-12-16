package kr.or.ddit.autumn.management.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.BoardVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface CommunityManagerDAO {
	public int insertCommunity(BoardVO board);
	public List<BoardVO> selectCommunityList(PagingVO<BoardVO> paging);
	public int updateCommunity(BoardVO board);
	public int selectTotalRecord(PagingVO<BoardVO> paging);
	public String searchCode(String code);
	public int deleteCommunity(@Param("boCode") String boCode);
	public List<PostVO> retrieveChildPost(@Param("boCode") String boCode);
	public int deleteChildPost(PostVO post);
	public int deleteComment(PostVO post);
	public List<AttatchVO> selectAttatchList(PostVO post);

}
