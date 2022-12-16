package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.attendance.dao.AttendPrivacyDAO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendPrivacyServiceImpl implements AttendPrivacyService {

	public final AttendPrivacyDAO dao;
	
	
	@Override
	public AttendEmployeeVO retrieveMyPrivacyInfo(String empId) {
		return dao.selectMyPrivacyInfo(empId);
	}

	@Override
	public List<AttendEmployeeVO> retrieveDeptPrivacyInfoList(AttendPagingVO pagingVO) {
		return dao.selectDeptPrivacyList(pagingVO);
	}

	@Override
	public int retrieveTotalRecord(AttendPagingVO pagingVO) {
		return dao.selectTotalRecord(pagingVO);
	}

	@Override
	public int retrieveTotalDeptPrivacy(AttendEmployeeVO attendVO) {
		return dao.selectTotalDeptPrivacy(attendVO);
	}

	@Override
	public AttatchVO retrieveProfileImage(String empId) {
		return dao.selectProfileImage(empId);
	}

}
