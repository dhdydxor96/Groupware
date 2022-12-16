package kr.or.ddit.autumn.groupware.mail.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.autumn.groupware.mail.vo.ReceiveMailVO;

public interface MailReaderService {
	public List<ReceiveMailVO> receiveMailAttachedFile(HttpServletRequest request,String userName, String password, Date startDate, Date endDate);
	
	public void setSaveDirectory(String dir);
	
	public List<ReceiveMailVO> deleteMail(Integer mailNo, String userName, String password);
}
