package kr.or.ddit.autumn.management.group.employee.service;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.management.RuntimeErrorException;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.exception.PKNotFoundException;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.management.group.employee.dao.ManagementEmployeeAttatchDAO;
import kr.or.ddit.autumn.management.group.employee.dao.ManagementEmployeeDAO;
import kr.or.ddit.autumn.management.group.employee.dao.ManagementEmployeePowerDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ManagementEmployeeServiceImpl implements ManagementEmployeeService{
	
	private final ManagementEmployeeDAO empDAO;
	private final ManagementEmployeeAttatchDAO attatchDAO;
	private final ManagementEmployeePowerDAO powerDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	
	private int processAttatchList(EmployeeVO employee) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = employee.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt = attatchDAO.insertAttatches(employee);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}

	@Override
	public ServiceResult createEmployee(EmployeeVO employee) {
		String empPass = employee.getEmpPass();
		try {
			String encodingEmpPass = encrypt(empPass);
			employee.setEmpPass(encodingEmpPass);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
		int rowcnt = empDAO.insertEmployee(employee);
		rowcnt += processAttatchList(employee);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public EmployeeVO retrieveEmployee(String empId) {
		EmployeeVO employee = empDAO.selectEmployee(empId);
		if(employee == null)
			throw new RuntimeException(String.format("%d 사원아이디의 사원이 없음.", empId));
		return employee;
	}

	@Override
	public int retrieveEmpCount(PagingVO<EmployeeVO> pagingVO) {
		return empDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public List<EmployeeVO> retrieveEmployeeList(PagingVO<EmployeeVO> pagingVO) {
		return empDAO.selectEmployeeList(pagingVO);
	}

	@Override
	public ServiceResult modifyEmployee(EmployeeVO employee) {
		ServiceResult result = null;
		int rowcnt = empDAO.updateEmployee(employee);
		
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	
	private int processDeleteAttatch(EmployeeVO employee) {
		int[] delAttNos = employee.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos);
		List<AttatchVO> attatchList = empDAO.selectEmployee(employee.getEmpId()).getAttatchList();
		List<String> saveNames = attatchList.stream()
				.filter(attatch->{
					return Arrays.binarySearch(delAttNos, attatch.getAttNo()) >= 0;
				}).map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = attatchDAO.deleteAttatches(delAttNos);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				File deleteFile = new File(savePath, attSavename);
				FileUtils.deleteQuietly(deleteFile);
			}
		}
		return rowcnt;
	}
	
	private int processDeleteAttatches(EmployeeVO employee) {
		List<AttatchVO> attatchList = empDAO.selectEmployee(employee.getEmpId()).getAttatchList();
		
		if(attatchList==null || attatchList.isEmpty()) return 0;
		
		List<String> saveNames = attatchList.stream()
				.map(attatch->{
					return attatch.getAttSnm();
				}).collect(Collectors.toList());
		int rowcnt = 0;
		rowcnt = attatchDAO.deleteAttatch(employee.getEmpId());
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames) {
				File deleteFile = new File(savePath, attSavename);
				FileUtils.deleteQuietly(deleteFile);
			}
		}
		return rowcnt;
	}
	

	@Override
	public ServiceResult removeEmployee(EmployeeVO employee) {
		ServiceResult result = null;
		processDeleteAttatches(employee);
		PowerVO power = new PowerVO();
		powerDAO.deletePowerUser(power);
		int rowcnt = empDAO.deleteEmployee(employee);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public AttatchVO retrieveAttatch(String empId) {
		AttatchVO attatch = attatchDAO.selectAttatch(empId);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}

	@Override
	public List<DepartmentVO> retrieveDepartmentList(String comCode) {
		return empDAO.selectDepartmentList(comCode);
	}

	@Override
	public List<JobVO> retrieveJobList(String comCode) {
		return empDAO.selectJobList(comCode);
	}

	@Override
	public List<EmployeeVO> retrieveResignationList(PagingVO<EmployeeVO> pagingVO) {
		return empDAO.selectResignationList(pagingVO);
	}

	@Override
	public ServiceResult removeResignation(EmployeeVO employee) {
		ServiceResult res = null;
		int rowcnt = empDAO.deleteResignation(employee);
		res = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return res;
	}

	@Override
	public int idCheck(EmployeeVO employee) {
		int result = empDAO.idCheck(employee);
		return result;
	}

	@Override
	public int retrieveResignationEmpCount(PagingVO<EmployeeVO> pagingVO) {
		return empDAO.selectRestignationTotalRecord(pagingVO);
	}
	
	// 단방향 암호화 
		public String encrypt(String inputPassword) throws NoSuchAlgorithmException {
			PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();

			String encoded = encoder.encode(inputPassword);
			
			log.info("bcrypt 암호화 진행 {}", encoded);
			
			return encoded;
		}

	
}
