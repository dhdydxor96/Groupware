package kr.or.ddit.autumn.groupware.profile.controller;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.profile.service.GroupwareProfileService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/profile")
@RequiredArgsConstructor
public class PasswordUpdateController {

	private final GroupwareProfileService service;
	
	@GetMapping("/passwordUpdate.do")
	public String passwordUpdateUI() {
		return "groupware/profile/passwordUpdateForm";
	}
	
	// ================================
	// * 프로필 관리 - 비밀번호 변경
	// ================================
	@PostMapping(value="/passwordUpdate.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String passwordUpdate(Authentication authentication, @RequestParam("currentPassword") String currentPassword, 
				@RequestParam("newPassword") String newPassword
			) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		ServiceResult retrieveResult = null;
		ServiceResult updateResult = ServiceResult.FAIL;
		
		// DB의 비밀번호와 입력한 비밀번호가 일치하는지 확인
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmpId(empId);
		employeeVO.setEmpPass(currentPassword);
		
		retrieveResult = service.retrieveMyPassword(employeeVO);
		
		String message ="";
		
		if(retrieveResult.equals(ServiceResult.OK)) {
			// 일치하는 경우에 업데이트 진행
			employeeVO.setEmpPass(newPassword);
			updateResult = service.updateMyPassword(employeeVO);
			
			if(updateResult.equals(ServiceResult.OK)) {
				// 비밀번호 변경에 성공했을 때
				message = "비밀번호 변경에 성공하였습니다.";
				
			}else {
				// 비밀번호 변경에 실패했을 때
				message = "비밀번호 변경에 실패하였습니다.";
			}

		}else {
			message = "비밀번호가 일치하지 않습니다.";
		}
		
		log.info("비밀번호 변경 시 결과값 : {}" , message);
		
		return message;
	}
}
