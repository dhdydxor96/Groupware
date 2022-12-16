package kr.or.ddit.autumn.groupware.resource.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.resource.service.ResourceService;
import kr.or.ddit.autumn.groupware.resource.vo.ReservVO;
import kr.or.ddit.autumn.groupware.resource.vo.ResourcePagingVO;
import kr.or.ddit.autumn.groupware.resource.vo.RoomVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/groupware/resource")
@RequiredArgsConstructor
public class ResourceDelController {
	
	private final ResourceService service;

	// ================================
	// * 회의실 예약 삭제
	// ================================
	@ResponseBody
	@RequestMapping(value="/resourceDel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResourcePagingVO<ReservVO> myDeleteResource(Authentication authentication, @RequestParam(value="what")int revNo,  RedirectAttributes ratt) {
		
		// 로그인한 본인 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realUser = adapter.getRealUser();
		
		String empId = realUser.getEmpId();
		
		
		// 본인의 예약 삭제
		ServiceResult serviceResult = service.removeMyResource(revNo);

		
		if(serviceResult.equals(ServiceResult.FAIL)) {
			ratt.addFlashAttribute("message", "서버 문제로 삭제를 실패하였습니다. 다시 시도해주세요.");
		}

		
		// 사용 전/사용완료 변경
		service.updateResourceStatus();
		
		// 본인의 예약 리스트 출력
		SearchVO simpleCondition = new SearchVO();
		ResourcePagingVO<ReservVO> pagingVO = new ResourcePagingVO<>(5,3);
		pagingVO.setEmpId(empId);
		pagingVO.setCurrentPage(1);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.selectResourceTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ReservVO> reserList = service.retrieveMyResourceList(pagingVO);
		pagingVO.setDataList(reserList);
		
		return pagingVO;
	}
}
