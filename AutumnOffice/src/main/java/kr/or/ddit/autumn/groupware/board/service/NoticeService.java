package kr.or.ddit.autumn.groupware.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface NoticeService {
	
	/** 그룹웨어 사용자 공지사항 리스트
	 * @param paging
	 * @return PostVO 리스트(공지사항에 등록된 목록)
	 */
	public List<NoticeVO> retrieveNoticeList(PagingVO<NoticeVO> pagingVO);
	
	/** 그룹웨어 사용자 공지사항 페이징 TotalRecord 카운팅
	 * @param paging
	 * @return 해당 조건의 개수 카운팅
	 */
	public int retrieveNoticeCount(PagingVO<NoticeVO> pagingVO);
	
	/**	그룹웨어 사용자 공지사항 상세보기
	 * @param poNo 공지사항 게시글 번호를 통해 조인하여 해당 회사의 공지사항 조회
	 * @return 게시글 내용이 담긴 PostVO
	 */
	public NoticeVO retrieveNotice(int nocNo);
	
	/**	그룹웨어 사용자 첨부파일 조회
	 * @param attNo	파일 번호를 통해 해당 첨부파일 조회
	 * @return	첨부파일의 메타 데이터가 담긴 AttatchVO 
	 */
	public AttatchVO retrieveAttatch(@Param("attNo") int attNo);


}
