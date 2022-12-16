package kr.or.ddit.autumn.groupware.profile.service;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.groupware.profile.dao.GroupwareProfileDAO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class GroupwareProfileServiceImpl implements GroupwareProfileService {

	@Inject
	private GroupwareProfileDAO dao;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	
	// 파일 등록
	private int processAttatch(EmployeeVO employeeVO) {
		int rowcnt = 0;
		
		List<AttatchVO> attatchList = employeeVO.getAttatchList();
		AttatchVO attatchVO = new AttatchVO();
		
		log.info("ServiceImpl에서 attatchList 정보값 {}" , employeeVO.getAttatchList());
		
		if(attatchList!=null && !attatchList.isEmpty()) {
			
			attatchVO.setEmpId(employeeVO.getEmpId());
			attatchVO.setAttFnm(employeeVO.getAttatchList().get(0).getAttFnm());
			attatchVO.setAttSnm(employeeVO.getAttatchList().get(0).getAttSnm());
			attatchVO.setAttMime(employeeVO.getAttatchList().get(0).getAttMime());
			attatchVO.setAttFis(employeeVO.getAttatchList().get(0).getAttFis());
			attatchVO.setAttFas(employeeVO.getAttatchList().get(0).getAttFas());
			
			rowcnt = dao.insertProfileImage(attatchVO);
			
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}
	
	// 파일 삭제
	private int processDeleteAttatches(EmployeeVO employee) {
		AttatchVO attatchVO = dao.selectEmployeeAttatchInfo(employee.getEmpId());
		
		if(attatchVO==null) return 0;
		
		String saveName = attatchVO.getAttSnm();

		int rowcnt = 0;

		rowcnt = dao.deleteProfileImage(employee.getEmpId());
		
		if(!saveName.isEmpty()) {
				File deleteFile = new File(savePath, saveName);
				FileUtils.deleteQuietly(deleteFile);
		}
		return rowcnt;
	}
	
	@Transactional
	@Override
	public ServiceResult updateProfileImage(EmployeeVO employeeVO) {
		
		ServiceResult result = null;
		
		int rowcnt = 0;
		
		rowcnt += processDeleteAttatches(employeeVO);
		rowcnt += processAttatch(employeeVO);
		
		if(rowcnt >=1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}


	@Override
	public List<LogVO> retrieveLoginIpInfo(AttendPagingVO pagingVO) {
		return dao.selectLoginIpInfo(pagingVO);
	}

	@Override
	public int retrieveLoginIpInfoTotalCount(AttendPagingVO pagingVO) {
		return dao.selectLoginIpInfoTotalCount(pagingVO);
	}

	//======비밀번호 변경
	@Override
	public ServiceResult updateMyPassword(EmployeeVO employeeVO) {
		ServiceResult result = null;
		
		log.info("비밀번호 변경을 위해 값이 제대로 들어오는지 확인 {}", employeeVO);
		
		String encodedPassword = "";
		
		try {
			encodedPassword = encrypt(employeeVO.getEmpPass());
		} catch (NoSuchAlgorithmException e) {
			log.error("비밀번호 변경을 위해 단방향 암호화 진행도중 에러 {}", e);
		}
		
		employeeVO.setEmpPass(encodedPassword);
		
		int rownum =  dao.updateMyPassword(employeeVO);
		
		if(rownum>=1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public ServiceResult retrieveMyPassword(EmployeeVO employeeVO) {
		ServiceResult result = null;
		
		// DB에서 받아온 나의 비밀번호
		String savedPassword = dao.selectMyPassword(employeeVO);

		boolean cryptoResult = false;
		
		// 사용자가 비밀번호를 변경하기 위해 입력한 현재 비밀번호
		try {
			cryptoResult = encryptTest(employeeVO.getEmpPass(), savedPassword);
		} catch (NoSuchAlgorithmException e) {
			log.error("단방향 암호화 진행중 에러 {}", e);
		}
		
		if(cryptoResult==true) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}
	
	// 단방향 암호화 
	public String encrypt(String inputPassword) throws NoSuchAlgorithmException {
		PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();

		String encoded = encoder.encode(inputPassword);
		
		log.info("bcrypt 암호화 진행 {}", encoded);
		
		return encoded;
	}
	
	// 단방향 암호화 후 기존의 데이터와 비교
	public boolean encryptTest(String inputPassword, String savedPassword) throws NoSuchAlgorithmException {
		PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		
		String encoded = encoder.encode(inputPassword);
		
		log.info("bcrypt 암호화 진행 {}", encoded);
		
		boolean result = encoder.matches(inputPassword, savedPassword);
		
		log.info("matches 값 {}", result );
		
		return result;
	}

}
