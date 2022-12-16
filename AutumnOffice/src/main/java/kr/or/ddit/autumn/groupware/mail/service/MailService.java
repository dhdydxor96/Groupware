package kr.or.ddit.autumn.groupware.mail.service;

import kr.or.ddit.autumn.vo.SendMailVO;

public interface MailService {
	
	//메일 보내기

	public boolean mailSend(SendMailVO sendMailVO, String nickName, String fromAddress, String password);
}
