package kr.or.ddit.autumn.commons.login.service;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.login.dao.LoginDAO;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Service("authService")
public class LoginServiceImpl implements UserDetailsManager{

	@Inject
	private LoginDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		EmployeeVO emp = dao.findByPk(username);
		if(emp == null) 
			throw new UsernameNotFoundException(username);
		return new EmployeeVOWrapper(emp);
	}
	
	@Override
	public void createUser(UserDetails user) {
	}

	@Override
	public void updateUser(UserDetails user) {
	}

	@Override
	public void deleteUser(String username) {
	}

	@Override
	public void changePassword(String oldPassword, String newPassword) {
	}

	@Override
	public boolean userExists(String username) {
		return false;
	}

}
