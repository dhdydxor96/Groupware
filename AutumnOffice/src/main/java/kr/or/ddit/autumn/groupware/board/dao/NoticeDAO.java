package kr.or.ddit.autumn.groupware.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface NoticeDAO {
	/**	공지사항 상세보기 
	 * @param poNo
	 * @return 공지사항의 상세보기 내용이 담긴 PostVO 반환
	 */
	public NoticeVO selectNotice(@Param("nocNo") int nocNo);
	
	/**	공지사항의 조회수 추가
	 * @param poNo 공지사항 게시글 번호
	 * @return poNo 게시물의 조회수에 +1 해주고 반환
	 */
	public int incrementNoHit(@Param("nocNo") int nocNo);
	
	/** 페이징 처리에 필요한 게시물의 개수 조회
	 * @param paging
	 * @return 게시물의 개수 반환
	 */
	public int selectTotalRecord(PagingVO<NoticeVO> pagingVO);
	
	/**	공지사항 리스트 반환 
	 * @param paging
	 * @return 리스트의 제네릭 타입 PostVO는 제목, 작성자 등을 담고 있음. 
	 */
	public List<NoticeVO> selectNoticeList(PagingVO<NoticeVO> pagingVO);
	
	/**	공지사항의 첨부파일 조회
	 * @param attNo
	 * @return	첨부파일의 메타데이터를 담아와준다.
	 */
	public AttatchVO selectAttatch(@Param("attNo") int attNo);


}
