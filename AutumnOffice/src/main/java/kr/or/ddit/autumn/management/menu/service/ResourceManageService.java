package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.vo.MeetInfoVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ResourceManageService {

	/**
	 * 회의실 리스트 조회 (페이징 처리)
	 * @param pagingVO
	 * @return
	 */
	public List<MeetRoomVO> retrieveMeetRoomList(PagingVO pagingVO);
	
	/**
	 * 페이징 처리용
	 * @param pagingVO
	 * @return
	 */
	public int selectTotalCount(PagingVO pagingVO);
	
	/**
	 * 회의실 등록
	 * @param meetRoom=등록하기 위한 회의실 정보
	 * @return
	 */
	public ServiceResult createMeetRoom(ResourceInfoVO meetInfo);

	
	/**
	 * 회의실 상세정보 수정
	 * @param meetInfo= 수정하기 위한 회의실의 상세정보
	 * @return
	 */
	public ServiceResult updateMeetInfo(ResourceInfoVO meetInfo);
	
	/**
	 * 회의실 삭제 (1개)
	 * @param meetNo= 삭제하기 위한 회의실 번호
	 * @return
	 */
	public ServiceResult removeMeetRoom(int meetNo);
	
	//============================================
	
	/**
	 * 회의실 상세정보 조회
	 * @param meetNo=상세정보를 확인하기 위한 회의실 번호
	 * @return
	 */
	public ResourceInfoVO retrieveMeetInfo(int meetNo);
	
	
	//============================================
	
}
