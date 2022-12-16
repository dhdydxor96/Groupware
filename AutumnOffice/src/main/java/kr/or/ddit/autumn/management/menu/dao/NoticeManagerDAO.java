package kr.or.ddit.autumn.management.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface NoticeManagerDAO {
	public int insertNotice(NoticeVO notice);
	
	public NoticeVO selectNotice(@Param("nocNo") int nocNo);
	public int incrementNoHit(@Param("nocNo") int nocNo);
	public int selectTotalRecord(PagingVO<NoticeVO> pagingVO);
	public List<NoticeVO> selectNoticeList(PagingVO<NoticeVO> pagingVO);
	
	
	public int updateNotice(NoticeVO notice);
	public int deleteNotice(NoticeVO notice);
	public int deleteNot(@Param("nocNo")  int nocNo);
	public void deleteNotice(String nocNo);
	
	public List<AttatchVO> selectAttatchList(NoticeVO notice);
	public List<AttatchVO> selectAttList(@Param("nocNo") int nocNo);
}
