package kr.or.ddit.autumn.commons.login.vo;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.autumn.vo.CompanyVO;

public class CompanyVOWrapper extends User{

	private CompanyVO realUser;

	public CompanyVOWrapper(CompanyVO realUser) {
		super(realUser.getComId(), realUser.getComPass(), AuthorityUtils.createAuthorityList("ROLE_ADMIN"));
		this.realUser = realUser;
	}
	
	public CompanyVO getRealUser() {
		return realUser;
	}
	
}
