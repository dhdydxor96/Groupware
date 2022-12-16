package kr.or.ddit.autumn.groupware.attendance.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.attendance.dao.AttendPrivacyDAO;
import kr.or.ddit.autumn.groupware.attendance.dao.AttendStatusDAO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.vo.EmpStatusVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class AttendStatusServiceImpl implements AttendStatusService {

	public final AttendStatusDAO dao;
	public final AttendPrivacyDAO privacyDao;
	
	@Override
	public ServiceResult createMyStartWork(String empId) {
		ServiceResult result;
		
		int rownum = dao.insertMyStartWork(empId);
		
		if(rownum >= 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public List<StatusVO> retrieveMyStatus(String empId) {
		return dao.selectMyStatus(empId);
	}

	@Override
	public ServiceResult updateMyEndWork(String empId) {
		ServiceResult result;
		
		int rownum = dao.updateMyEndWork(empId);
		
		if(rownum >= 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public int retrieveMyStartWorkOverlap(String empId) {
		return dao.selectMyStartWorkOverlap(empId);
	}

	@Override
	public StatusVO retrieveMyStatusSum(String empId) {
		StatusVO status = new StatusVO();

		
		int second = dao.selectMyStatusSum(empId);
		
		// 이번주 누적 시간 계산
		int hh = second/3600;
		int mi = second%3600/60;
		
		String sumTime = hh+"h "+mi+"m";
		status.setSumTime(sumTime);
		
		// 이번주 초과/잔여 시간 계산
		int overTimeAll = 144000 - second;
		int oh = overTimeAll/3600;
		int om = overTimeAll%3600/60;
		
		String overTime = null;
		
		if(overTimeAll <0) {
			overTime = (-oh)+"h "+(-om)+"m";
			
			status.setOverTime(overTime);
			status.setLeftTime("00h 00m");
		}else {
			
			overTime = oh+"h "+om+"m";
			
			status.setOverTime("00h 00m");
			status.setLeftTime(overTime);
		}
		
		
		
		return status;
	}

	@Override
	public StatusVO retrieveMyStatusSumMonth(String empId) {
		StatusVO status = new StatusVO();
		
		int second = dao.selectMyStatusSumMonth(empId);
		
		// 이번달 누적 시간 계산
		int hh = second/3600;
		int mi = second%3600/60;
		
		String sumTime = hh+"h "+mi+"m";
		status.setSumTime(sumTime);
		
		// 이번달 초과 시간 계산
		int overTimeAll = 576000 - second;
		int oh = overTimeAll/3600;
		int om = overTimeAll%3600/60;
		
		String overTime = null;
		
		if(overTimeAll <0) {
			overTime = 	(-oh)+"h "+(-om)+"m";
			status.setOverTime(overTime);
		}else {
			status.setOverTime("00h 00m");
		}
		
		
		return status;
	}

	@Override
	public List<StatusVO> retrieveDeptStatus(PagingVO pagingVO) {
		List<StatusVO> list = dao.selectDeptStatus(pagingVO);
		
		List<StatusVO> timeList = dao.selectDeptStatusTime(pagingVO);
		
		for(StatusVO sta : list) {
			for(StatusVO timeSta : timeList) {
				if(StringUtils.isNotBlank(timeSta.getEmpId()) && timeSta.getEmpId().equals(sta.getEmpId())) { 
					// 누적시간(timeList)의 부서원아이디와 부서근태현황(list)의 부서원 아이디가 일치하고
					if(!StringUtils.isNotBlank(timeSta.getStaInd()) && StringUtils.isNotBlank(timeSta.getSumSecond())) {
						//true면 timeList에서 중간소계의 컬럼이란 뜻 (총 누적시간)
						
						// 누적 시간 계산
						log.info("받아온 누적시간 숫자로 변환 {} : {}", sta.getEmpId(),  Math.floor(Double.parseDouble(timeSta.getSumSecond())));
						int hh =  (int) Math.floor(Double.parseDouble(timeSta.getSumSecond()))/3600;
						int mi = (int) Math.floor(Double.parseDouble(timeSta.getSumSecond()))%3600/60;
						
						String sumTime = hh+"h "+mi+"m";
						
						sta.setSumSecond(sumTime);
					}
				}
			}
		}
		
		return list;
	}

	@Override
	public List<StatusVO> retrieveDeptStatusTime(PagingVO pagingVO) {
		return dao.selectDeptStatusTime(pagingVO);
	}

	@Override
	public StatusVO retrieveMyWorkInfo(String empId) {
		StatusVO status = dao.selectMyWorkInfo(empId);
		
		if(status!=null) {
			
			int second = (int) Double.parseDouble(status.getSumSecond());
			
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
			// 미등록용 정보 띄우기
			StatusVO nonStatus = new StatusVO();
			
			AttendEmployeeVO empVO = privacyDao.selectMyPrivacyInfo(empId);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	        Calendar c1 = Calendar.getInstance();

	        String strToday = sdf.format(c1.getTime());

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
	public ServiceResult updateDeptEmployeeInfo(StatusVO status) throws ParseException {
		
		log.info("AttendStatusUpdateController 제대로 날짜 데이터 들어오나 {}", status.getUpdateDay().replace("T"," "));
		
		String replaceDay = status.getUpdateDay().replace("T"," ");

		// 받아온 날짜 데이터를 TimeStamp 형태로 변환 -- 2022-11-11 18:52:10 "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		LocalDateTime localDateTime = LocalDateTime.parse(status.getUpdateDay(), DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
		
		Date dateTime = java.sql.Timestamp.valueOf(localDateTime);
		
		String time = simpleDateFormat.format(dateTime);
		
		log.info("AttendStatusUpdateController timeStamp 변환 {}", time);
		
		// 받아온 날짜 데이터를 Date 형태로 변환 -- 2022-11-11
		SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		
		Date sqlDate = simpleDateFormat2.parse(replaceDay);
		
		String date = simpleDateFormat2.format(sqlDate);
		
		log.info("AttendStatusUpdateController Date 변환 {}", date);
		
		status.setUpdateDay(date);
		
		if(status.getEscCode().equals("C")) {
			// 지각으로 인한 시간 변동인 경우
			status.setStaOnt(time);
		}else if(status.getEscCode().equals("B") || status.getEscCode().equals("F")) {
			// 퇴근, 조퇴로 인한 시간 변동인 경우
			status.setStaOft(time);
		}
		
		int rownum = dao.updateDeptEmployeeInfo(status);
		ServiceResult result = null;
		
		if(rownum >= 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public List<StatusVO> retrieveDeptChangeStatus(String empId) {
		return dao.selectDeptChangeStatus(empId);
	}

	@Override
	public int selectTotalCount(PagingVO pagingVO) {
		return dao.selectTotalCount(pagingVO);
	}

}
