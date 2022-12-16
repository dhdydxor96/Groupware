package kr.or.ddit.autumn.groupware.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.LveRecodeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface DepAnnualHistoryDAO {

	/** 
	 * (당일) 부서 연차 사용 내역
	 * @param department 내가 해당된 부서
	 * @return
	 */
	public List<LveRecodeVO> depAnnualHistoryList(AttendEmployeeVO depInfo);
	
	/**
	 * 부서 연차 사용 내역 확인
	 * @param department
	 * @return
	 */
	public List<LveRecodeVO> depAnnualHistoryAllList(DepartmentVO department);
	
	/**
	 * @param pagingVO 페이징처리
	 * @return
	 */
	public int historyRecode(PagingVO<LveRecodeVO> pagingVO);
	
	/**
	 * 부서 연차 사용 내역 확인 (페이징 처리용)
	 * @param HistoryRecodeList
	 * @return
	 */
	public List<LveRecodeVO> historyRecodeList(PagingVO<LveRecodeVO> pagingVO);
}
