package kr.or.ddit.autumn.management.menu.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;

@Mapper
public interface NoticeManagerAttatchDAO {
	
	
	public int insertAttatches(NoticeVO notice);
	public int searchAttNo(String attSnm);
	public AttatchVO selectAttatch(@Param("attNo") int attNo);
	public int deleteAttatches(@Param("delAttNos") int[] delAttNos);
	public int deleteChildPostFile(@Param("delAttNos") int[] delAttNos);
	public int deleteAttatch(int nocNo);
}
