package kr.or.ddit.autumn.groupware.approval.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.groupware.approval.vo.ApprovalFormVO;
import kr.or.ddit.autumn.groupware.approval.vo.DocBoxPagingVO;
import kr.or.ddit.autumn.vo.AplDetailVO;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.AppLineVO;
import kr.or.ddit.autumn.vo.AppStatusVO;
import kr.or.ddit.autumn.vo.AulLeaveVO;
import kr.or.ddit.autumn.vo.BusTripVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EleDecideVO;
import kr.or.ddit.autumn.vo.EleRefVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LveRecodeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface ApprovalDAO {
	/**
	 * 회사 문서 양식 리스트 조회
	 * @param comCode
	 * @return
	 */
	public List<AppFormVO> selectAppFormList(@Param("comCode") String comCode);
	/**
	 * 회사 부서 리스트 조회
	 * @param comCode
	 * @return
	 */
	public List<DepartmentVO> selectDepartmentList(@Param("comCode") String comCode);
	/**
	 * 회사 부서 리스트조회 사원, 직위 포함
	 * @param comCode
	 * @return
	 */
	public List<DepartmentVO> selectDeptGroupList(@Param("comCode") String comCode);
	
	// ===================================================
	// 결재 작성하기
	// ===================================================
	/**
	 * 기안문서 하나 추가
	 * @param elecApp
	 * @return
	 */
	public int insertApproval(ElecAppVO elecApp);
	/**
	 * 결재선 상세 (결재순서) 추가
	 * @param appLineList
	 * @return
	 */
	public int insertAplDetail(List<AppLineVO> appLineList);
	/**
	 * 결재선 추가 (나의 결재선, 일반 구분하기 위해)
	 * @param approvalForm
	 * @return
	 */
	public int insertAppLine(ApprovalFormVO approvalForm);
	/**
	 * 결재선 번호 최대값 조회
	 * @return
	 */
	public int selectCountAppLine();
	/**
	 * 참조자 리스트 추가
	 * @param eleRefList
	 * @return
	 */
	public int insertEleRef(List<EleRefVO> eleRefList);
	/**
	 * 결재상태 추가(기본 APS_STATUS = 0[진행중])
	 * @param aplNo
	 * @return
	 */
	public int insertAppStatus(@Param("aplNo")int aplNo);
	/**
	 * 결재선 번호에 대한 기안문서 번호 조회
	 * @param aplNo
	 * @return
	 */
	public int selectEleNo(@Param("aplNo")int aplNo);
	// ---------------------------------------------------
	
	// ===================================================
	// 기안 목록 불러오기
	// ===================================================
	/**
	 * 기안문서 번호 최대값 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectElecAppTotalRecord(DocBoxPagingVO<ElecAppVO> pagingVO);
	/**
	 * 기안문서 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<ElecAppVO> selectElecAppList(DocBoxPagingVO<ElecAppVO> pagingVO);
	
	// ===================================================
	// 기안 세부 조회
	// ===================================================
	/**
	 * 기안 문서 한건 조회
	 * @param eleNo
	 * @return
	 */
	public ElecAppVO selectElecApp(@Param("eleNo") int eleNo);
	/**
	 * 기안 문서에 대한 참조자 리스트 조회
	 * @param eleNo
	 * @return
	 */
	public List<EleRefVO> selectEleRefList(@Param("eleNo") int eleNo);
	
	
	// ===================================================
	// 결재하기
	// ===================================================
	/**
	 * 결재 승인시 APL_STA(결재상태)-1, APL_STA(결재차례)-2 업데이트
	 * @return
	 */
	public int updateApproval(AplDetailVO aplDetail);
	/**
	 * 앞사람이 승인 시 다음차례인 사람 업데이트
	 * @return
	 */
	public int updateSetNextLine(AplDetailVO aplDetail);
	/**
	 * 반려 시 업데이트
	 * @return
	 */
	public int updateReferApp(AplDetailVO aplDetail);
	
	/**
	 * 결재문서의 결재선 조회
	 * @param aplNo
	 * @return
	 */
	public List<AplDetailVO> selectAplDetailList(@Param("aplNo") int aplNo);
	
	/**
	 * 다음 결재할 사람 조회
	 * @param aplNo
	 * @return
	 */
	public AplDetailVO selectNextApl(@Param("aplNo") int aplNo);
	
	/**
	 * 결재 문서 종류 조회
	 * @param aplNo
	 * @return 문서 종류
	 */
	public String selectApfCat(@Param("eleNo")int eleNo);
	
	/**
	 * 승인 완료된 휴가 문서 추가
	 * @param elecApp
	 * @return
	 */
	public int insertVacation(ElecAppVO elecApp);
	
	/**
	 * 승인 완료된 출장 문서 추가
	 * @param elecApp
	 * @return
	 */
	public int insertBusTrip(ElecAppVO elecApp);
	
	/**
	 * 문서 번호에 맞는 연차 문서 조회
	 * @param eleNo
	 * @return
	 */
	public AulLeaveVO selectAulLeave(@Param("eleNo") int eleNo);
	
	/**
	 * 문서의 시작일 종료일 조회
	 * @param eleNo
	 * @return
	 */
	public ElecAppVO selectElecAppDate(@Param("eleNo") int eleNo);
	
	/**
	 * 연차 사용기록 추가
	 * @param lveRecode
	 * @return
	 */
	public int insertLveRecode(LveRecodeVO lveRecode);
	
	/**
	 * 연차 업데이트
	 * @param aulNo
	 * @return
	 */
	public int updateAulLeave(@Param("aulNo")int aulNo);
	
	public int updateLeftoverAnnual(@Param("empId")String empId);
	
	/**
	 * 최종 승인시 결재상태 업데이트
	 * @param appStatus
	 * @return
	 */
	public int updateAppStatus(AppStatusVO appStatus);
	
	/**
	 * 결재 상태 반려 업데이트
	 * @param appStatus
	 * @return
	 */
	public int updateCancelAps(AppStatusVO appStatus);
	
	/**
	 * 결재선 상세 반려 업데이트
	 * @param aplDetail
	 * @return
	 */
	public int updateCancelApl(AplDetailVO aplDetail);
	
	/**
	 * 문서의 결재 상태 조회
	 * @param aplNo
	 * @return
	 */
	public AppStatusVO selectAppStatus(@Param("aplNo") int aplNo);
	
	
	// ===================================================
	// 결재 환경설정 업데이트
	// ===================================================
	/**
	 * 서명 이미지 업데이트
	 * @param employee
	 * @return
	 */
	public int updateEmpSign(EmployeeVO employee);
	
	/**
	 * 결재선 상세 삭제
	 * @param aplNo
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */
	public int deleteAplDetail(@Param("aplNo") int aplNo);
	
	/**
	 * 결재선 삭제
	 * @param aplNo
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */
	public int deleteAppLine(@Param("aplNo") int aplNo);
	
	/**
	 * 결재 상태 삭제
	 * @param eleNo
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */
	public int deleteAppStatus(@Param("eleNo") int eleNo);
	
	/**
	 * 전자 결재 문서 삭제
	 * @param eleNo
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */
	public int deleteElecApp(@Param("eleNo") int eleNo);
	
	/**
	 * 참조자 삭제
	 * @param eleNo
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */
	public int deleteEleRef(@Param("eleNo") int eleNo);
	
	/**
	 * 첨부파일 삭제
	 * @param eleNo
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */ 
	public int deleteAttatch(@Param("eleNo") int eleNo);
	
	/**
	 * 부재/위임 등록
	 * @param eleDecide
	 * @return 성공 : 삽입된 컬럼 수, 실패 : 0
	 */
	public int insertEleDecide(EleDecideVO eleDecide);
	
	/**
	 * 등록된 부재/위임 리스트 조회
	 * @param empId
	 * @return
	 */
	public List<EleDecideVO> selectEleDecideList(@Param("empId") String empId);
	
	/**
	 * 오늘 날짜의 대결자 조회
	 * @param empId
	 * @return
	 */
	public String selectEleDecide(@Param("empId") String empId);
	
	/**
	 * 등록된 부재/위임 삭제
	 * @param eleDecide
	 * @return 성공 : 삭제된 컬럼 수, 실패 : 0
	 */
	public int deleteEleDecide(EleDecideVO eleDecide);
}
