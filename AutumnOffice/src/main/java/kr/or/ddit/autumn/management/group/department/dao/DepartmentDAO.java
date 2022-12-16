package kr.or.ddit.autumn.management.group.department.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface DepartmentDAO {
	/**
	 * 부서 신규 등록
	 * @param department
	 * @return
	 */
	public int insertDepartment(DepartmentVO department);
	/**
	 * 검색 조건에 맞는 레코드 수(totalRecord)조회
	 * @param pagingVO
	 * @return
	 */
	public int selectTotalRecord(PagingVO<DepartmentVO> pagingVO);
	/**
	 * 검색 조건에 맞는 레코드 목록(dataList) 조회
	 * @param pagingVO
	 * @return
	 */
	public List<DepartmentVO> selectDepartmentList(PagingVO<DepartmentVO> pagingVO);
	/**
	 * 부서 상세 조회
	 * @param depId
	 * @return
	 */
	public DepartmentVO selectDepartment(@Param("depId") String depId);
	/**
	 * 부서 수정
	 * @param department
	 * @return
	 */
	public int updateDepartment(DepartmentVO department);
	/**
	 * 부서 삭제
	 * @param depId
	 * @return
	 */
	public int deleteDepartment(DepartmentVO department);
	/**
	 * 부서 아이디 중복 체크
	 * @param department
	 * @return
	 */
	public int idCheck(DepartmentVO department);
	public List<DepartmentVO> departmentList(DepartmentVO department);
	public List<PowerVO> selectHeadList(PowerVO power);
}
