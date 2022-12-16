package kr.or.ddit.autumn.commons.login.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.autumn.vo.EmployeeVO;


public class EmployeeVOWrapper extends User{
	private EmployeeVO realUser;

	public EmployeeVOWrapper(EmployeeVO realUser) {
		super(realUser.getEmpId(), realUser.getEmpPass(), AuthorityUtils.createAuthorityList(realUser.getEmpRoles().stream().toArray(String[]::new)) );
		this.realUser = realUser;
	}
	
	public EmployeeVO getRealUser() {
		return realUser;
	}

}
