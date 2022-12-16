package kr.or.ddit.autumn.groupware.main.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.groupware.main.dao.GroupwareMainDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GroupwareMainServiceImpl implements GroupwareMainService {

	private final GroupwareMainDAO dao;
 	
	@Override
	public List<NoticeVO> retrieveNoticeList(String comCode) {
		return dao.selectNoticeList(comCode);
	}

	@Override
	public List<PostVO> retrieveCommunityList(String comCode) {
		return dao.selectCommunityList(comCode);
	}

	@Override
	public List<CalendarVO> retrieveCalendarList(EmployeeVO employeeVO) {
		return dao.selectCalendarList(employeeVO);
	}

	@Override
	public List<ElecAppVO> retrieveMyApprovalList(String empId) {
		return dao.selectMyApprovalList(empId);
	}

	@Override
	public AttatchVO retrieveMyInfo(String empId) {
		return dao.selectMyInfo(empId);
	}

	@Override
	public StatusVO retrieveMyWorkInfo(String empId) {
		StatusVO status = dao.selectMyWorkInfo(empId);
		
		if(status!=null) {
			// ==========================
			// 현재 출근한 상태
			// ==========================
			
			// 총 누적시간을 초 단위로 불러온다.
			int second = (int) Double.parseDouble(status.getSumSecond());
			
			// 퇴근시간이 존재하지 않다면 미등록
			if(!StringUtils.isNotBlank(status.getStaOft())) {
				status.setStaOft("(미등록)");
			}
			
			// 이번주 누적 시간 계산
			int hh = second/3600;
			int mi = second%3600/60;
			
			String sumTime = hh+"h "+mi+"m";
			status.setSumTime(sumTime);
			
			return status;
		}else {
			// ==========================
			// 출근 전 상태
			// ==========================
			StatusVO nonStatus = new StatusVO();
			
			AttendEmployeeVO empVO = dao.selectMyPrivacyInfo(empId);
			
			// 테이블에 출근 날짜가 등록되지 않은 상태이므로
			// JAVA에서 오늘 날짜를 불러온다.
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());

	        // 모든 값에 미등록용 정보 넣어주기
			nonStatus.setStaOnt("(미등록)");
			nonStatus.setStaOft("(미등록)");
			nonStatus.setEmpNm(empVO.getEmpNm());
			nonStatus.setJobNm(empVO.getJobNm());
			nonStatus.setSumTime("0h 0m");
			nonStatus.setStaInd(strToday);

			return nonStatus;
		}
	}

	@Override
	public AttendEmployeeVO retrieveMyPrivacyInfo(String empId) {
		return dao.selectMyPrivacyInfo(empId);
	}

	@Override
	public AttatchVO retrieveCompanyLogo(String comCode) {
		return dao.selectCompanyLogo(comCode);
	}

}
