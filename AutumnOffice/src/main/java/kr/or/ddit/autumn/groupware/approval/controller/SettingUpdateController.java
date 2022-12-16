package kr.or.ddit.autumn.groupware.approval.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.vo.EleDecideVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Controller
@RequestMapping("/groupware/approval/setting")
public class SettingUpdateController {
	
	@Inject
	private ApprovalService service;
	
	// 서명 관리 뷰 이동
	@GetMapping("/signUpdate.do")
	public String signUpdateUI() {
		return "groupware/approval/signUpdateView";
	}
	
	// 부재 관리 뷰 이동
	@GetMapping("/absenceHome.do")
	public String absenceHomeUI() {
		return "groupware/approval/absenceView";
	}
	
	@GetMapping(value="/absenceHome.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<EleDecideVO> absenceList(@AuthenticationPrincipal(expression="realUser") EmployeeVO employee){
		return service.retrieveEleDecideList(employee.getEmpId());
	}
	
	// 부재 추가 뷰 이동
	@GetMapping("/absenceInsert.do")
	public String absenceInsertUI() {
		return "groupware/approval/absenceForm";
	}
	
	// 부재 추가
	@PostMapping("/appProxyInsert.do")
	public String appProxyInsert(EleDecideVO eleDecide, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee) {
		
		eleDecide.setEmpId(employee.getEmpId());
		
		ServiceResult result = service.createEleDecide(eleDecide);
		if(result == ServiceResult.FAIL) {
			throw new RuntimeException("대결자 insert error");
		}
		
		return "redirect:/groupware/approval/setting/absenceHome.do";
	}
	
	@PostMapping(value="/appProxyDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, consumes=MediaType.ALL_VALUE)
	@ResponseBody
	public boolean appProxyDelete(@RequestParam(name="empProxys[]")int[] empProxys, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee) {
		System.out.println(empProxys.toString());
		ServiceResult result = service.removeEleDecide(empProxys);
		boolean flag = true;
		if(result == ServiceResult.FAIL) {
			flag = false;
			throw new RuntimeException("부재 설정 삭제 실패");
		}
		return flag;
	}
	
}
