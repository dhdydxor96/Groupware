package kr.or.ddit.autumn.groupware.mail.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.ImportMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ImportMailService {

	    //메일 상세 
		public ImportMailVO retrieveImportMail(Integer maiNo);
		
		//메일 리스트
		public List<ImportMailVO> retrieveImportMailList(PagingVO<ImportMailVO> pagingVO);
		
		//노페이징 메일 리스트
		public List<ImportMailVO> noPageRetrieveImportMailList(String empId);

		//중요 메일함 추가
		public ServiceResult createImportMailVO(ImportMailVO importMailVO);
		
		//중요 메일함 삭제
		public ServiceResult removeImportMailVO(ImportMailVO importMailVO);
		
		//중요 메일함 카운트
		public int retrieveImportMailCount(PagingVO<ImportMailVO> pagingVO);
		
		//파일 가져오기
//		public AttatchVO retrieveAttatch(int attNo);
}
