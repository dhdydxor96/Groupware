package kr.or.ddit.autumn.commons.login.service;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.login.dao.LoginDAO;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.vo.CompanyVO;

@Service("ManageAuthService")
public class ManageLoginServiceImpl implements UserDetailsManager{
	
	@Inject
	private LoginDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		CompanyVO company = dao.findByComPk(username);
		if(company == null) 
			throw new UsernameNotFoundException(username);
		return new CompanyVOWrapper(company);
	}

	@Override
	public void createUser(UserDetails user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateUser(UserDetails user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteUser(String username) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void changePassword(String oldPassword, String newPassword) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean userExists(String username) {
		// TODO Auto-generated method stub
		return false;
	}

}
