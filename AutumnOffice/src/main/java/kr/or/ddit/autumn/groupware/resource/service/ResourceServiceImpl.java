package kr.or.ddit.autumn.groupware.resource.service;


import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.resource.dao.ResourceDAO;
import kr.or.ddit.autumn.groupware.resource.vo.ReservVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourcePagingVO;
import kr.or.ddit.autumn.groupware.resource.vo.RoomVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.MeetReserVO;
import kr.or.ddit.autumn.vo.MeetTimeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ResourceServiceImpl implements ResourceService {
 
	private final ResourceDAO resourceDAO;
	
	@Override
	public List<ReservVO> retrieveMyResourceList(ResourcePagingVO pagingVO) {
		return resourceDAO.selectMyResourceList(pagingVO);
	}

	@Override
	public List<ReservVO> retrieveMyList(String empId) {
		return resourceDAO.selectMyList(empId);
	}

	@Override
	public List<RoomVO> retrieveAllResourceList(ResourcePagingVO pagingVO) {
		return resourceDAO.selectAllResourceList(pagingVO);
	}
	
	@Override
	public int selectResourceTotalCount(ResourcePagingVO pagingVO) {
		return resourceDAO.selectResourceTotalCount(pagingVO);
	}
	
	@Override
	public List<RoomVO> retrieveCompanyAllResourceList(String companyCode) {
		return resourceDAO.selectCompanyAllResourceList(companyCode);
	}
	
	//========================================================
	// 회의실 상세보기
	//========================================================

	@Override
	public ResourceInfoVO retrieveResourceDetail(int meetNo) {
		return resourceDAO.selectResourceView(meetNo);
	}

	@Override
	public List<MeetTimeVO> selectTimeList() {
		return resourceDAO.selectTimeList();
	}

	@Override
	public ServiceResult createResource(MeetReserVO meetReserVO) {
		ServiceResult serviceResult = null;
		
		// 본인이 예약하고자 하는 시간대에 예약이 있는지 확인
		int status = retrieveCompareList(meetReserVO);
		
		if(status==1) {
			// 예약 불가
			serviceResult = ServiceResult.PKDUPLICATED;
			return serviceResult;
		}
		
		// 예약 등록
		int rownum= resourceDAO.insertResourceReserv(meetReserVO);
		
		if(rownum==1) {
			serviceResult = ServiceResult.OK;
		}else if(rownum==0) {
			serviceResult = ServiceResult.FAIL;
		}
		
		return serviceResult;
	}

	@Override
	public int retrieveCompareList(MeetReserVO meetReserVO) {
		return resourceDAO.selectCompareList(meetReserVO);
	}


	@Override
	public List<ReservVO> retrieveRoomList(ReservVO reservVO) {
		return resourceDAO.selectRoomList(reservVO);
	}

	@Override
	public ServiceResult removeMyResource(int revNo) {
		
		ServiceResult serviceResult = null;
		
		int rownum = resourceDAO.deleteMyResource(revNo);
		
		if(rownum==1) {
			serviceResult = ServiceResult.OK;
		}else if(rownum==0) {
			serviceResult = ServiceResult.FAIL;
		}
		
		return serviceResult;
	}

	@Override
	public List<ReservVO> retrieveReservTableList(int meetNo) {
		return resourceDAO.selectReservTableList(meetNo);
	}

	@Override
	public int updateResourceStatus() {
		return resourceDAO.updateResourceStatus();
	}

	@Override
	public AttatchVO retrieveResourceImage(int meetNo) {
		return resourceDAO.selectResourceImage(meetNo);
	}

}
