package kr.or.ddit.autumn.groupware.approval.service;

import java.text.ParseException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.approval.vo.ApprovalFormVO;
import kr.or.ddit.autumn.groupware.approval.vo.DocBoxPagingVO;
import kr.or.ddit.autumn.vo.AplDetailVO;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.AppStatusVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EleDecideVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ApprovalService {
	/**
	 * 문서 양식 리스트 조회
	 * @return List<AppFormVO>
	 */
	public List<AppFormVO> retrieveAppFormList(String comCode);
	
	/**
	 * 부서 리스트 조회
	 * @return List<DepartmentVO>
	 */
	public List<DepartmentVO> retrieveDepartmentList(String comCode);
	
	/**
	 * 전체 부서, 부서에 속한 사원, 근태코드 조회
	 * @param comCode 회사코드
	 * @return List<DepartmentVO>
	 */
	public List<DepartmentVO> retrieveDeptGroupList(String comCode);
	
	/**
	 * 작성한 결재 문서 추가, 결재선 등록
	 * @return
	 */
	public ServiceResult createApproval(ApprovalFormVO approvalForm);
	
	/**
	 * 기안 문서 총 레코드 수 반환
	 * @param pagingVO
	 * @return
	 */
	public int retrieveElecAppCount(DocBoxPagingVO<ElecAppVO> pagingVO);
	
	/**
	 * 기안 문서 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<ElecAppVO> retrieveElecAppList(DocBoxPagingVO<ElecAppVO> pagingVO);
	
	/**
	 * 기안 문서 세부 조회
	 * @param eleNo
	 * @return
	 */
	public ElecAppVO retrieveElecApp(int eleNo);
	
	/**
	 * 기안 문서 첨부파일 세부 조회
	 * @param attNo
	 * @return
	 */
	public AttatchVO retrieveAttatch(int attNo);
	
	/**
	 * 결재 승인할 시에 AplDetail 테이블 수정
	 * 다음 결재자가 있을시에는 결재 상태, 결재 순번만 변경
	 * 최종 결재자인 경우 문서 양식에 따라서 휴가, 출장, 연차 등등 테이블에 연계하여 insert후 
	 * 문서 상태 변경하여 최종 승인 처리
	 * @param aplDetail
	 * @param eleNo
	 * @return
	 */
	public ServiceResult modifyAplDetail(AplDetailVO aplDetail, int eleNo);
	
	/**
	 * 문서의 결재자들 조회
	 * @param aplNo
	 * @return
	 */
	public List<AplDetailVO> retrieveAplDetailList(int aplNo);
	
	/**
	 * 서명 이미지 수정
	 * @param employee
	 * @return
	 */
	public ServiceResult modifyEmpSign(EmployeeVO employee);
	
	/**
	 * 문서 반려시에 문서 상태 반려로 변경, 반려 진행한 결재자 상태를 반려로 변경
	 * @param eleNo 반려한 문서 번호
	 * @param aplDetail 결재자 리스트
	 * @param cancel 반려 내용
	 * @return
	 */
	public ServiceResult modifyCancel(int eleNo, AplDetailVO aplDetail, String cancel);
	
	/**
	 * 결재선 번호에 해당하는 문서 상태 조회
	 * @param aplNo 결재선 번호
	 * @return
	 */
	public AppStatusVO retrieveAppStatus(int aplNo);
	
	/**
	 * 결재 문서 삭제, 결재선 상세 -> 결재 상태 -> 결재 참조(있을시) -> 파일(있을시) -> 결재 문서 -> 결재선 테이블 순으로 삭제 진행
	 * @param elecApp eleNo, aplNo가 셋팅된 ElecAppVO
	 * @return
	 */
	public ServiceResult removeElecApp(ElecAppVO elecApp);
	
	/**
	 * 부재/위임 추가
	 * @param eleDecide
	 * @return
	 */
	public ServiceResult createEleDecide(EleDecideVO eleDecide);
	
	/**
	 * 부재/위임 리스트 조회
	 * @param empId
	 * @return
	 */
	public List<EleDecideVO> retrieveEleDecideList(String empId);
	
	/**
	 * 부재/위임 리스트 삭제
	 * @param empProxys
	 * @param empId
	 * @return
	 */
	public ServiceResult removeEleDecide(int[] empProxys);
}
