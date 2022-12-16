package kr.or.ddit.autumn.groupware.mail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.SendMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;


@Mapper
public interface SendMailDAO {

	
	//메일 상세 
	public SendMailVO selectSendMail(Integer mailNo);
	
	//메일 리스트
	public List<SendMailVO> selectSendMailList(PagingVO<SendMailVO> pagingVO);

	public List<SendMailVO> noPageSelectSendMailList(String empId);
	
	//보낸 메일함 추가
	public int insertSendMailVO(SendMailVO sendMailVO);
	
	//보낸 메일함 삭제
	public int deleteSendMailVO(@Param("mailNo") Integer mailNo);
	
	//전체 카운트
	public int selectTotalRecord(PagingVO<SendMailVO> pagingVO);
}
