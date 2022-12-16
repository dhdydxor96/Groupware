package kr.or.ddit.autumn.groupware.mail.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.mail.dao.ImportMailDAO;
import kr.or.ddit.autumn.vo.ImportMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Service
public class ImportMailServiceImpl implements ImportMailService {

	@Inject
	private ImportMailDAO dao;


	
	
	@Override
	public ImportMailVO retrieveImportMail(Integer maiNo) {
		ImportMailVO importMailVO = dao.selectImportMail(maiNo);
		if(importMailVO==null)
			throw new RuntimeException(String.format("%d 번호의 메일이 없음.", maiNo));
		
		return importMailVO;
	}

	@Override
	public List<ImportMailVO> retrieveImportMailList(PagingVO<ImportMailVO> pagingVO) {
		return dao.selectImportMailList(pagingVO);
	}
	
	
	@Override
	public List<ImportMailVO> noPageRetrieveImportMailList(String empId) {
		
		return dao.noPageSelectImportMailList(empId);
	}


	@Override
	public ServiceResult createImportMailVO(ImportMailVO importMailVO) {
		int rowcnt = dao.insertImportMailVO(importMailVO);
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeImportMailVO(ImportMailVO importMailVO) {
		ServiceResult result = null;
		
	
			int rowcnt = dao.deleteImportMailVO(importMailVO.getMaiNo());
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	
		return result;
	}
	
	
	//보낸 메일함 카운트
	@Override
	public int retrieveImportMailCount(PagingVO<ImportMailVO> pagingVO) {
		return dao.selectTotalRecord(pagingVO);
	}



}
