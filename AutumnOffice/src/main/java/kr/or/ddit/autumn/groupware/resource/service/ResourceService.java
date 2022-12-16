package kr.or.ddit.autumn.groupware.resource.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.resource.vo.ReservVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourcePagingVO;
import kr.or.ddit.autumn.groupware.resource.vo.RoomVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.MeetReserVO;
import kr.or.ddit.autumn.vo.MeetTimeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ResourceService {

	
	/**
	 * 나의 예약 현황 확인
	 * @param pagingVO= 현황을 확인하고자 하는 본인의 ID
	 * @return 본인의 예약 현황 리스트
	 */
	public List<ReservVO> retrieveMyResourceList(ResourcePagingVO pagingVO);

	/**
	 * 나의 예약 현황 확인 (삭제용)
	 * @param empId= 현황을 확인하고자 하는 본인의 ID
	 * @return 본인의 예약 현황 리스트
	 */
	public List<ReservVO> retrieveMyList(String empId);
	
	/**
	 * 회의실 별 예약 현황
	 * @param pagingVO= 본인의 회사의 코드번호
	 * @return 전체 회의실의 예약 현황 리스트
	 */
	public List<RoomVO> retrieveAllResourceList(ResourcePagingVO pagingVO);
	
	/**
	 * 회의실 별 예약 현황
	 * @param companyCode= 본인의 회사의 코드번호
	 * @return 전체 회의실의 예약 현황 리스트
	 */
	public List<RoomVO> retrieveCompanyAllResourceList(String companyCode);
	
	/**
	 * 페이징 처리용
	 * @param pagingVO
	 * @return
	 */
	public int selectResourceTotalCount(ResourcePagingVO pagingVO);

	//============================================================
	/**
	 * 회의실 상세보기
	 * @param meetNo= 상세조회하려는 회의실 번호
	 * @return 회의실의 상세정보
	 */
	public ResourceInfoVO retrieveResourceDetail(int meetNo);
	
	/**
	 * 시간 리스트(1번-9:00~10:00 ..) 조회
	 * @return 시간 리스트
	 */
	public List<MeetTimeVO> selectTimeList();
	
	/**
	 * 회의실 예약
	 * @param meetReserVO=예약하려는 회의실 정보
	 * @return 1:성공 0:실패
	 */
	public ServiceResult createResource(MeetReserVO meetReserVO);

	/**
	 * 회의실을 예약하기 전에, 본인이 예약하고자 하는 시간에 예약이 되어있는지 확인
	 * @param meetReserVO
	 * @return 1: 예약불가 0: 예약가능
	 */
	public int retrieveCompareList(MeetReserVO meetReserVO);
	
	/**
	 * 회의실의 주간 예약 현황 (몇시에 누가 예약해놨는지)
	 * @param meetReserVO= 회의실번호, 검색기간
	 * @return 회의실 주간 예약 현황
	 */
	public List<ReservVO> retrieveRoomList(ReservVO reservVO);
	
	/**
	 * 나의 예약 삭제
	 * @param revNo= 예약번호
	 * @return
	 */
	public ServiceResult removeMyResource(int revNo);
	
	/**
	 * 회의실 예약 현황 테이블로 띄우기
	 * @param reservVO = 회의실번호, 기간지정
	 * @return= 테이블 형식의 데이터값
	 */
	public List<ReservVO> retrieveReservTableList(int meetNo);

	/**
	 * 날짜와 시간에 맞춰 회의실 예약 사용 여부 변경 (사용전->사용후)
	 * @return 1이상:성공 0:실패
	 */
	public int updateResourceStatus();
	
	/**
	 * 회의실 이미지 가져오기
	 * @param meetNo= 이미지를 가져올 회의실 번호
	 * @return 회의실 정보 (그안에 attatchVO 정보 포함)
	 */
	public AttatchVO retrieveResourceImage(int meetNo);
}
