package kr.or.ddit.autumn.commons.login.service;

import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;

import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.login.dao.LoginFindPasswordDAO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginFindPasswordServiceImpl implements LoginFindPasswordService {

	@Inject
	private LoginFindPasswordDAO dao;
	
	@Override
	public int checkEmp(EmployeeVO checkEmployee) {
		return dao.checkEmp(checkEmployee);
	}

	@Override
	public int updateEmp(EmployeeVO updateEmployee) {
		
		try {
			String encoding = encrypt(updateEmployee.getEmpPass());
			updateEmployee.setEmpPass(encoding);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return dao.updateEmp(updateEmployee);
	}
	
	public String encrypt(String inputPassword) throws NoSuchAlgorithmException {
		PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();

		String encoded = encoder.encode(inputPassword);
		
		log.info("bcrypt 암호화 진행 {}", encoded);
		
		return encoded;
	}

}
