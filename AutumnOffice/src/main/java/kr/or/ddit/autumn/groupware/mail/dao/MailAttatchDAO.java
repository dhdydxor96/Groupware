package kr.or.ddit.autumn.groupware.mail.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.SendMailVO;

@Mapper
public interface MailAttatchDAO {
	/**
	 * 게시글의 첨부파일의 메타데이터를 한번에 Insert.
	 * @param board
	 * @return
	 */
	public int insertAttatches(SendMailVO sendMailVO);
	/**
	 * 다운로드 처리를 위해 메타데이터 한건 조회.
	 * @param attNo
	 * @return
	 */
	public AttatchVO selectAttatch(int attNo);

	
	public int deleteAttatches(int mailNo);
	
}
