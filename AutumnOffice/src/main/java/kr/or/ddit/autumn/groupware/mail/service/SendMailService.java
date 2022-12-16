package kr.or.ddit.autumn.groupware.mail.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.SendMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface SendMailService {

	    //메일 상세 
		public SendMailVO retrieveSendMail(Integer mailNo);
		
		//메일 리스트
		public List<SendMailVO> retrieveSendMailList(PagingVO<SendMailVO> pagingVO);

		public List<SendMailVO> noPageRetrieveSendMailList(String empId);
		
		//보낸 메일함 추가
		public ServiceResult createSendMailVO(String[] toMails, SendMailVO sendMailVO);
		
		//보낸 메일함 삭제
		public ServiceResult removeSendMailVO(SendMailVO sendMailVO);
		
		//보낸 메일함 카운트
		public int retrieveSendMailCount(PagingVO<SendMailVO> pagingVO);
		
		//파일 가져오기
		public AttatchVO retrieveAttatch(int attNo);
}
