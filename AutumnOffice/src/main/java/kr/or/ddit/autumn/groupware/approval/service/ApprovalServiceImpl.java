package kr.or.ddit.autumn.groupware.approval.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.ftp.FtpUtil;
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.groupware.approval.dao.ApprovalAttatchDAO;
import kr.or.ddit.autumn.groupware.approval.dao.ApprovalDAO;
import kr.or.ddit.autumn.groupware.approval.vo.ApprovalFormVO;
import kr.or.ddit.autumn.groupware.approval.vo.DocBoxPagingVO;
import kr.or.ddit.autumn.vo.AplDetailVO;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.AppLineVO;
import kr.or.ddit.autumn.vo.AppStatusVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.AulLeaveVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EleDecideVO;
import kr.or.ddit.autumn.vo.EleRefVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LveRecodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalServiceImpl implements ApprovalService{
	
	@Inject
	private ApprovalDAO dao;
	@Inject
	private ApprovalAttatchDAO attatchDAO;
	
	@Inject
	private FtpUtil ftpUtil; 
	
	@Value("#{ftpInfo.savePath}")
	private String savePath;
	
	@Inject
	private NotifyService notifyService;
	
	public List<AppFormVO> retrieveAppFormList(String comCode) {
		return dao.selectAppFormList(comCode);
	}

	@Override
	public List<DepartmentVO> retrieveDepartmentList(String comCode) {
		return dao.selectDepartmentList(comCode);
	}

	@Override
	public List<DepartmentVO> retrieveDeptGroupList(String comCode) {
		return dao.selectDeptGroupList(comCode);
	}
	
	@Transactional
	@Override
	public ServiceResult createApproval(ApprovalFormVO approvalForm) {
		// 결재선 번호 셋팅
		int aplNo = dao.selectCountAppLine() + 1;
		approvalForm.setAplNo(aplNo);
		log.info("결재선 번호 : {}", aplNo);

		// 결재선 DB에 insert
		int rowcnt = dao.insertAppLine(approvalForm);
		log.info("결재선 DB INSERT...");
		log.info("Result : [{}]", rowcnt);
		
		List<String> proxyRefList = new ArrayList<>();
		
		// 결재선 리스트
		List<AppLineVO> appLineList = new ArrayList<AppLineVO>();
		// 결재자로 등록된 사람들 한명씩 리스트에 셋팅
		for(String empId : approvalForm.getAppId()) {
			AppLineVO appLine = new AppLineVO();
			
			appLine.setAplNo(aplNo);
			appLineList.add(appLine);
			
			String proxyId = dao.selectEleDecide(empId);
			if(proxyId == null) {
				appLine.setEmpId(empId);
			}else {
				appLine.setEmpId(proxyId);
				appLine.setDecSta("1");
				proxyRefList.add(empId);
			}
		}
		// 결재선 상세 DB에 insert
		rowcnt += dao.insertAplDetail(appLineList);
		log.info("결재선 상세 DB INSERT...");
		log.info("PARAMETER : {}", appLineList);
		log.info("Result : [{}]", rowcnt);
		
		// 결재 문서 셋팅
		ElecAppVO elecApp = new ElecAppVO();
		elecApp.setEmpId(approvalForm.getEmpId());
		elecApp.setAplNo(aplNo);
		elecApp.setApfNo(approvalForm.getApfNo());
		elecApp.setEleTit(approvalForm.getEleTit());
		elecApp.setEleUse(approvalForm.getEleUse());
		elecApp.setEleCon(approvalForm.getAppContent());
		elecApp.setEleYn(approvalForm.isEleYn());
		elecApp.setDepId(approvalForm.getDepId());
		elecApp.setEleStart(approvalForm.getEleStart());
		elecApp.setEleEnd(approvalForm.getEleEnd());
		
		// 결재 문서 DB insert
		rowcnt += dao.insertApproval(elecApp);
		log.info("결재 문서 DB INSERT...");
		log.info("PARAMETER : {}", elecApp);
		log.info("Result : [{}]", rowcnt);
		
		// 결재 문서 pk 값 셋팅
		Integer eleNo = dao.selectEleNo(aplNo);
		approvalForm.setEleNo(eleNo);
		
		
		List<String> refIdList = approvalForm.getRefId();
		// 셋팅할 참조 VO 리스트
		
		// 참조자ID 리스트
		List<EleRefVO> eleRefList = new ArrayList<>();
		if(refIdList != null) {
			for(String refId : refIdList) {
				EleRefVO eleRef = new EleRefVO();
				eleRef.setEmpId(refId);
				eleRef.setEleNo(eleNo);
				eleRefList.add(eleRef);
			}
		}
		if(proxyRefList.size() > 0) {
			for(String refId : proxyRefList) {
				EleRefVO eleRef = new EleRefVO();
				eleRef.setEmpId(refId);
				eleRef.setEleNo(eleNo);
				if(eleRefList.contains(eleRef)) {
					continue;
				}
				eleRefList.add(eleRef);
			}
		}
		//참조자알림 
		for(EleRefVO eleRefVO:eleRefList) {
			notifyService.notifyInsertModule(eleRefVO.getEmpId(), 8);
		}
//		for(int i=0; i<eleRefList.size(); i++) {
//			EleRefVO eleRefVO = eleRefList.get(i);
//			if(i==0) {
//				notifyService.notifyInsertModule(eleRefVO.getEmpId(), 6);
//			}else{
//				notifyService.notifyInsertModule(appLine.getEmpId(), 1);	
//			}
//		}
		// 참조 DB에 insert
		rowcnt += dao.insertEleRef(eleRefList);
		log.info("참조 DB INSERT...");
		log.info("PARAMETER : {}", eleRefList);
		log.info("Result : [{}]", rowcnt);
		
		// 결재 상태 DB에 insert
		rowcnt += dao.insertAppStatus(aplNo);
		log.info("결재 상태 DB INSERT...");
		log.info("PARAMETER : {}", aplNo);
		log.info("Result : [{}]",rowcnt);
		
		// 파일 처리
		rowcnt += processAttatchList(approvalForm);
		log.info("첨부 파일 DB INSERT...");
		log.info("PARAMETER : {}", approvalForm);
		log.info("Result : [{}]", rowcnt);
		

		//결제선알림
		for(int i=0; i<appLineList.size(); i++) {
			AppLineVO appLine = appLineList.get(i);
			if(i==0) {
				notifyService.notifyInsertModule(appLine.getEmpId(), 6);
			}else{
				notifyService.notifyInsertModule(appLine.getEmpId(), 1);	
			}
		}
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	private int processAttatchList(ApprovalFormVO approvalForm) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = approvalForm.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			log.info("attatchDAO 첨부파일 insert...");
			rowcnt = attatchDAO.insertAttatches(approvalForm);
			for(AttatchVO attatch : attatchList) {
				ftpUtil.uploadToFtp(savePath, attatch.getAttSnm(), attatch.getAdaptee());
				log.info("파일 저장 경로 : {}", savePath);
			}
		}
		return rowcnt;
	}

	@Override
	public int retrieveElecAppCount(DocBoxPagingVO<ElecAppVO> pagingVO) {
		return dao.selectElecAppTotalRecord(pagingVO);
	}

	@Override
	public List<ElecAppVO> retrieveElecAppList(DocBoxPagingVO<ElecAppVO> pagingVO) {
		return dao.selectElecAppList(pagingVO);
	}

	@Override
	public ElecAppVO retrieveElecApp(int eleNo) {
		ElecAppVO elecApp = dao.selectElecApp(eleNo);
		List<EleRefVO> eleRefList = dao.selectEleRefList(eleNo);
		List<AttatchVO> attatchList = attatchDAO.selectAttatchList(eleNo);
		elecApp.setEleRefList(eleRefList);
		elecApp.setAttatchList(attatchList);
		
		return elecApp;
	}
	
	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		AttatchVO attatch = attatchDAO.selectAttatch(attNo);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}

	@Transactional
	@Override
	public ServiceResult modifyAplDetail(AplDetailVO aplDetail, int eleNo) {
		ServiceResult result = ServiceResult.FAIL;
		AplDetailVO nextApl = new AplDetailVO();
		// 결재 상태를 승인으로 변경
		int rowcnt = dao.updateApproval(aplDetail);
		
		// 성공 시
		if(rowcnt > 0) {
			// 다음 결재 차례인 사람 정보 가져오기
			nextApl = dao.selectNextApl(aplDetail.getAplNo());
			
			// 다음 결재자가 있을 경우
			if(nextApl != null) {
				// 다음 결재자 상태를 결재 대기상태로 업데이트
				rowcnt = dao.updateSetNextLine(nextApl);
				// 성공 시
				if(rowcnt > 0) result = ServiceResult.OK;
			}else {
				// 다음 결재자가 없을 경우
				String apfCat = dao.selectApfCat(eleNo);
				if(apfCat != null) {
					// 성공여부 판단할 rowcnt
					rowcnt = 0;
					ElecAppVO elecApp = dao.selectElecAppDate(eleNo);
					// 문서 양식 이름으로 switch 문 탐색 (연차, 출장, 휴가 면 date 처리)
					switch(apfCat) {
					case "연차":
						AulLeaveVO aulLeave = dao.selectAulLeave(eleNo);
						if(aulLeave != null) {
							// 연차 사용기록 insert 셋팅
							LveRecodeVO lveRecode = new LveRecodeVO();
							lveRecode.setEleNo(eleNo);
							lveRecode.setAulNo(aulLeave.getAulNo());
							lveRecode.setLerStart(elecApp.getEleStart());
							lveRecode.setLerEnd(elecApp.getEleEnd());
							
							rowcnt += dao.insertLveRecode(lveRecode);
							rowcnt += dao.updateLeftoverAnnual(elecApp.getEmpId());
						}
						break;
					case "출장":
						rowcnt += dao.insertBusTrip(elecApp);
						break;
					case "휴가":
						rowcnt += dao.insertVacation(elecApp);
						break;
					default:
						rowcnt = rowcnt + 1;
					}
					if(rowcnt > 0) {
						AppStatusVO appStatus = new AppStatusVO();
						appStatus.setEleNo(eleNo);
						appStatus.setApsStatus("1");
						rowcnt = dao.updateAppStatus(appStatus);
						if(rowcnt > 0) result = ServiceResult.OK;
						//알림 추가
						
						notifyService.notifyInsertModule(elecApp.getEmpId(), 2);
						
					}
				}
			}
		}
		return result;
	}
	
	@Override
	public List<AplDetailVO> retrieveAplDetailList(int aplNo){
		return dao.selectAplDetailList(aplNo);
	}
	
	@Override
	public AppStatusVO retrieveAppStatus(int aplNo) {
		return dao.selectAppStatus(aplNo);
	}

	@Override
	public ServiceResult modifyEmpSign(EmployeeVO employee) {
		ServiceResult result = null;
		
		int rowcnt = dao.updateEmpSign(employee);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Transactional
	@Override
	public ServiceResult modifyCancel(int eleNo, AplDetailVO aplDetail, String cancel) {
		
		ServiceResult result = null;
		
		AppStatusVO appStatus = new AppStatusVO();
		appStatus.setEleNo(eleNo);
		appStatus.setAplNo(aplDetail.getAplNo());
		appStatus.setApsRer(cancel);
		
		int rowcnt = dao.updateCancelAps(appStatus);
		if(rowcnt > 0) {
			rowcnt = dao.updateCancelApl(aplDetail);
			if(rowcnt > 0) {
				result = ServiceResult.OK;
			}
		}
		//반려를 하면 누가했는지랑(로그인한 사람이 반려한거임) 기안 올린사람이 필요()
		//참조자알림 
		ElecAppVO appVo = retrieveElecApp(appStatus.getEleNo());
		
			notifyService.notifyInsertModule(appVo.getEmpId(), 3);
		
		
		
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeElecApp(ElecAppVO elecApp) {
		
		int rowcnt = 0;
		ServiceResult result = ServiceResult.OK;
		rowcnt = dao.deleteAplDetail(elecApp.getAplNo());
		if(!(rowcnt > 0)) {
			throw new RuntimeException("결재선 상세 삭제 오류");
		}
		
		rowcnt = dao.deleteAppStatus(elecApp.getEleNo());
		if(!(rowcnt > 0)) {
			throw new RuntimeException("결재상태 삭제 오류");
		}
		
		if(elecApp.getEleRefList().size() > 0) {
			rowcnt = dao.deleteEleRef(elecApp.getEleNo());
			if(!(rowcnt > 0)) {
				throw new RuntimeException("결재 참조 삭제 오류");
			}
		}
		
		if(elecApp.getAttatchList().size() > 0) {
			rowcnt = dao.deleteAttatch(elecApp.getEleNo());
			if(!(rowcnt > 0)) {
				throw new RuntimeException("파일 삭제 오류");
			}
		}
		
		rowcnt = dao.deleteElecApp(elecApp.getEleNo());
		if(!(rowcnt > 0)) {
			throw new RuntimeException("결재 문서 삭제 오류");
		}
		
		rowcnt = dao.deleteAppLine(elecApp.getAplNo());
		if(!(rowcnt > 0)) {
			throw new RuntimeException("결재선 삭제 오류");
		}
		
		return result;
	}

	@Override
	public ServiceResult createEleDecide(EleDecideVO eleDecide) {
		
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = dao.insertEleDecide(eleDecide);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public List<EleDecideVO> retrieveEleDecideList(String empId) {
		return dao.selectEleDecideList(empId);
	}

	@Transactional
	@Override
	public ServiceResult removeEleDecide(int[] empProxys) {
		
		ServiceResult result = ServiceResult.OK;
		
		for(int empProxy : empProxys) {
			EleDecideVO eleDecide = new EleDecideVO();
			eleDecide.setEldNo(empProxy);
			
			int rowcnt = dao.deleteEleDecide(eleDecide);
			if( !(rowcnt > 0) ) {
				result = ServiceResult.FAIL;
				break;
			}
		}
		
		return result;
	}

}
