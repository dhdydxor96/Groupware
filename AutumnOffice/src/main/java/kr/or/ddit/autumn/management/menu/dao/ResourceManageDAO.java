package kr.or.ddit.autumn.management.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.MeetInfoVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface ResourceManageDAO {

	/**
	 * 회의실 리스트 조회 (페이징 처리)
	 * @param pagingVO
	 * @return
	 */
	public List<MeetRoomVO> selectMeetRoomList(PagingVO pagingVO);
	
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
	public int insertMeetRoom(MeetRoomVO meetRoom);
	
	/**
	 * 회의실 상세정보 및 회의실 첨부파일 등록할때 필요한 MEET_NO 조회
	 * @param infoVO=COMCODE, MEETNM
	 * @return
	 */
	public int selectMeetRoomNo(ResourceInfoVO infoVO);
	
	/**
	 * 회의실 상세정보 등록
	 * @param meetInfo=등록하기 위한 회의실의 상세정보
	 * @return
	 */
	public int insertMeetInfo(ResourceInfoVO meetInfo);
	
	/**
	 * 회의실 수정
	 * @param meetRoom=수정하기 위한 회의실 정보
	 * @return
	 */
	public int updateMeetRoom(MeetRoomVO meetRoom);
	
	/**
	 * 회의실 상세정보 수정
	 * @param meetInfo= 수정하기 위한 회의실의 상세정보
	 * @return
	 */
	public int updateMeetInfo(ResourceInfoVO meetInfo);
	
	/**
	 * 회의실 삭제 (1개)
	 * @param meetNo= 삭제하기 위한 회의실 번호
	 * @return
	 */
	public int deleteMeetRoom(int meetNo);
	
	/**
	 * 해당되는 회의실번호의 예약 현황 존재 여부 확인
	 * @param meetNo=예약 현황을 확인하기 위한 회의실 번호
	 * @return
	 */
	public int selectMeetReser(int meetNo);
	
	/**
	 * 해당되는 회의실번호의 예약 현황 삭제
	 * @param meetNo= 예약현황을 삭제하기 위한 회의실 번호
	 * @return
	 */
	public int deleteMeetReser(int meetNo);
	
	/**
	 * 해당되는 회의실 번호의 상세 정보 삭제
	 * @param meetNo= 상세 정보를 삭제하기 위한 회의실 번호
	 * @return
	 */
	public int deleteMeetInfo(int meetNo);
	
	//============================================
	
	/**
	 * 회의실 상세정보 조회
	 * @param meetNo=상세정보를 확인하기 위한 회의실 번호
	 * @return
	 */
	public ResourceInfoVO selectMeetInfo(int meetNo);
	
	
	//============================================
	
	/**
	 * 회의실 사진 등록
	 * @param attatch=회의실사진으로 등록하고자 하는 첨부파일 정보
	 * @return
	 */
	public int insertMeetRoomImage(AttatchVO attatch);

	/**
	 * 회의실 사진을 변경하기 위한 회의실 사진 정보 불러오기
	 * @param meetNo
	 * @return
	 */
	public AttatchVO selectMeetRoomImage(int meetNo);
	
	/**
	 * 회의실 사진 삭제
	 * @param meetNo
	 * @return
	 */
	public int deleteMeetRoomImage(int meetNo);
}
