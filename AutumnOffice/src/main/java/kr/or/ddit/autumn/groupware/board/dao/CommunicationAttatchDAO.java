package kr.or.ddit.autumn.groupware.board.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.PostVO;

@Mapper
public interface CommunicationAttatchDAO {
	

	public int insertAttatches(PostVO post);
	/**
	 * PostFile에 넣을 attNo 찾기.
	 * @param attSnm
	 * @return attNo
	 */
	public int searchAttNo(String attSnm);

	public AttatchVO selectAttatch(@Param("attNo") int attNo);
	
	public int deleteAttatches(@Param("delAttNos") int[] delAttNos);
	public int deleteChildPostFile(@Param("delAttNos") int[] delAttNos);
	public int deleteAttatch(int poNo);
	
}
