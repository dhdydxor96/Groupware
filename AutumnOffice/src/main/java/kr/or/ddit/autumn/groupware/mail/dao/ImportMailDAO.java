package kr.or.ddit.autumn.groupware.mail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.ImportMailVO;
import kr.or.ddit.autumn.web.vo.PagingVO;


@Mapper
public interface ImportMailDAO {

	
	//메일 상세 
	public ImportMailVO selectImportMail(Integer maiNo);
	
	//메일 리스트
	public List<ImportMailVO> selectImportMailList(PagingVO<ImportMailVO> pagingVO);
	
	//노페이징 메일 리스트
	public List<ImportMailVO> noPageSelectImportMailList(String empId);

	//중요 메일함 추가
	public int insertImportMailVO(ImportMailVO importMailVO);
	
	//중요 메일함 삭제
	public int deleteImportMailVO(@Param("maiNo") Integer maiNo);
	
	//전체 카운트
	public int selectTotalRecord(PagingVO<ImportMailVO> pagingVO);
}
